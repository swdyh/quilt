require File.dirname(__FILE__) + '/test_helper.rb'
require 'test/unit'
require 'digest/md5'
require 'fileutils'

class QultTest < Test::Unit::TestCase
  def setup
    @tmp_dir = File.join 'test', 'tmp'
    unless File.exist? @tmp_dir
      Dir.mkdir @tmp_dir
    end
  end

  def teardown
    if File.exist? @tmp_dir
      FileUtils.rm_r @tmp_dir
    end
  end

  def test_identicon
    identicon = Quilt::Identicon.new
    assert_instance_of Quilt::Identicon, identicon
    path = File.join 'test', 'tmp', 'test'
    identicon.write path
    assert File.exist?(path)
    File.unlink path
  end

  def test_to_blob
    identicon = Quilt::Identicon.new
    path_b = File.join 'test', 'tmp', 'test_to_blob.png'
    path_w = File.join 'test', 'tmp', 'test_write.png'

    open(path_b, 'w') {|f| f.write identicon.to_blob }
    identicon.write path_w

    digest = Proc.new {|path| Digest::MD5.hexdigest(IO.read(path)) }
    assert_equal digest.call(path_w), digest.call(path_w)

    File.unlink path_b, path_w
  end

  def test_digest
    digest = Quilt::Identicon.digest('foo')
    assert_not_nil digest
    Quilt::Identicon.salt = 'foo'
    assert_not_equal digest, Quilt::Identicon.digest('foo')
  end

  def test_image_lib
    image_other = Class.new do
      def initialize a, b, opt = {}; end
      def method_missing *arg; end
      def write path; open(path, 'w') {|f| f.puts 'other' }; end
    end

    libs = [Quilt::ImageGD, Quilt::ImageRmagick, image_other]
    libs.each do |lib|
      Quilt::Identicon.image_lib = lib
      assert_equal lib, Quilt::Identicon.image_lib
      identicon = Quilt::Identicon.new
      assert_equal lib, identicon.instance_variable_get(:@image).class
    end
  end

  def test_salt
    salts = ['foo', 'bar', 'baz']
    salts.each do |salt|
      Quilt::Identicon.salt = salt
      assert_equal salt, Quilt::Identicon.salt
    end
  end

  def test_size_opt_im
    size = 100
    Quilt::Identicon.image_lib = Quilt::ImageRmagick
    identicon = Quilt::Identicon.new 'foo', :size => size
    assert_equal size, identicon.instance_variable_get(:@image).instance_variable_get(:@image).rows
    assert_equal size, identicon.instance_variable_get(:@image).instance_variable_get(:@image).columns
  end

  def test_size_opt_gd
    size = 100
    Quilt::Identicon.image_lib = Quilt::ImageGD
    identicon = Quilt::Identicon.new 'foo', :size => size
    assert_equal size, identicon.instance_variable_get(:@image).instance_variable_get(:@image).width
    assert_equal size, identicon.instance_variable_get(:@image).instance_variable_get(:@image).height
  end
end
