# -*- coding: utf-8 -*-
require 'rubygems'
require 'digest/sha1'

module Quilt
  class ImageRmagick
    def initialize width, height
      require 'RMagick'
      @image = Magick::Image.new width, height
      @image.format = 'png'
    end

    def color r, g, b
      sprintf('#%02x%02x%02x', r, g, b)
    end

    def transparent color
      @image.transparent color
    end

    def fill_rect x, y, _x, _y, color
      dr = Magick::Draw.new
      dr.fill color
      dr.rectangle x, y, _x, _y
      dr.draw @image
    end

    def polygon points, color
      unless points.empty?
        dr = Magick::Draw.new
        dr.fill color
        dr.polygon *(points.flatten)
        dr.draw @image
      end
    end

    def write path
      open(path, 'w') {|f| f.puts @image.to_blob }
    end

    def to_blob
      @image.to_blob
    end

    def resize size
      @image.resize! size, size
    end
  end

  class ImageGD
    def initialize width, height
      require 'GD'
      @image = GD::Image.new width, height
    end

    def color r, g, b
      @image.colorAllocate r, g, b
    end

    def transparent color
      @image.transparent color
    end

    def fill_rect x, y, _x, _y, color
      @image.filledRectangle x, y, _x, _y, color
    end

    def polygon points, color
      poly = GD::Polygon.new
      points.each do |i|
        poly.addPt i[0], i[1]
      end
      @image.filledPolygon poly, color
    end

    def write path
      File.open(path, 'w') do |f|
        @image.png f
      end
    end

    def to_blob
      @image.pngStr
    end

    def resize size
      _image = GD::Image.new size, size
      # FIXME bug
      @image.copyResized _image, 0, 0, 0, 0, size, size, @image.width, @image.height
      @image = _image
    end
  end

  class Identicon
    PATCHES = [
               [0, 4, 24, 20, 0],
               [0, 4, 20, 0],
               [2, 24, 20, 2],
               [0, 2, 22, 20, 0],
               [2, 14, 22, 10, 2],
               [0, 14, 24, 22, 0],
               [2, 24, 22, 13, 11, 22, 20, 2],
               [0, 14, 22, 0],
               [6, 8, 18, 16, 6],
               [4, 20, 10, 12, 2, 4],
               [0, 2, 12, 10, 0],
               [10, 14, 22, 10],
               [20, 12, 24, 20],
               [10, 2, 12, 10],
               [0, 2, 10, 0],
               [],
              ]
    CENTER_PATCHES = [0, 4, 8, 15]
    PATCH_SIZE = 5
    @@image_lib = ImageRmagick
    @@salt = ''
    attr_reader :code

    def initialize str = '', opt = {}
      case opt[:type]
      when :code
        @code = str.to_i
      when :ip
        @code = Identicon.ip2code str
      else
        @code = Identicon.calc_code str.to_s
      end
      @decode = decode @code

      if opt[:size]
        @scale = opt[:size].to_f / (PATCH_SIZE * 3)
      else
        @scale = opt[:scale] || 1
      end

      @patch_width = PATCH_SIZE * @scale
      @image = @@image_lib.new @patch_width * 3, @patch_width * 3
      @back_color = @image.color 255, 255, 255
      @fore_color = @image.color @decode[:red], @decode[:green], @decode[:blue]
      @image.transparent @back_color
      render
    end

    def decode code
      {
        :center_type   => (code & 0x3),
        :center_invert => (((code >> 2) & 0x01) != 0),
        :corner_type   => ((code >> 3) & 0x0f),
        :corner_invert => (((code >> 7) & 0x01) != 0),
        :corner_turn   => ((code >> 8) & 0x03),
        :side_type     => ((code >> 10) & 0x0f),
        :side_invert   => (((code >> 14) & 0x01) != 0),
        :side_turn     => ((code >> 15) & 0x03),
        :red   => (((code >> 16) & 0x01f) << 3),
        :green => (((code >> 21) & 0x01f) << 3),
        :blue  => (((code >> 27) & 0x01f) << 3),
      }
    end

    def render
      center = [[1, 1]]
      side   = [[1, 0], [2, 1], [1, 2], [0, 1]]
      corner = [[0, 0], [2, 0], [2, 2], [0, 2]]

      draw_patches(center, CENTER_PATCHES[@decode[:center_type]],
                   0, @decode[:center_invert])
      draw_patches(side, @decode[:side_type],
                   @decode[:side_turn], @decode[:side_invert])
      draw_patches(corner, @decode[:corner_type],
                   @decode[:corner_turn], @decode[:corner_invert])
    end

    def draw_patches list, patch, turn, invert
      list.each do |i|
        draw(:x => i[0], :y => i[1], :patch => patch,
             :turn => turn, :invert => invert)
        turn += 1
      end
    end

    def draw opt = {}
      x = opt[:x] * @patch_width
      y = opt[:y] * @patch_width
      patch = opt[:patch] % PATCHES.size
      turn = opt[:turn] % 4

      if opt[:invert]
        fore, back = @back_color, @fore_color
      else
        fore, back = @fore_color, @back_color
      end
      @image.fill_rect(x, y, x + @patch_width - 1, y + @patch_width - 1, back)

      points = []
      PATCHES[patch].each do |pt|
        dx = pt % PATCH_SIZE
        dy = pt / PATCH_SIZE
        len = @patch_width - 1
        px = dx.to_f / (PATCH_SIZE - 1) * len
        py = dy.to_f / (PATCH_SIZE - 1) * len

        case turn
        when 1
          px, py = len - py, px
        when 2
          px, py = len - px, len - py
        when 3
          px, py = py, len - px
        end
        points << [x + px, y + py]
      end
      @image.polygon points, fore
    end

    def write path = "#{@code}.png"
      @image.write path
    end

    def to_blob
      @image.to_blob
    end

    def self.calc_code str
      extract_code Identicon.digest(str)
    end

    def self.ip2code ip
      code_ip = extract_code(ip.split('.'))
      extract_code Identicon.digest(code_ip.to_s)
    end

    def self.digest str
      Digest::SHA1.digest(str + @@salt)
    end

    def self.extract_code list
      if list.respond_to? :getbyte
        tmp = [list.getbyte(0) << 24, list.getbyte(1) << 16,
               list.getbyte(2) << 8, list.getbyte(3)]
      else
        tmp = [list[0].to_i << 24, list[1].to_i << 16,
               list[2].to_i << 8, list[3].to_i]
      end
      tmp.inject(0) do |r, i|
        r | ((i[31] == 1) ? -(i & 0x7fffffff) : i)
      end
    end

    def self.image_lib= image_lib
      @@image_lib = image_lib
    end

    def self.image_lib
      @@image_lib
    end

    def self.salt= salt
      @@salt = salt
    end

    def self.salt
      @@salt
    end
  end
end

