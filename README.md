# quilt

![sample01](http://swdyh.github.io/quilt/sample/quilt-01.png) ![sample02](http://swdyh.github.io/quilt/sample/quilt-02.png) ![sample03](http://swdyh.github.io/quilt/sample/quilt-03.png) ![sample04](http://swdyh.github.io/quilt/sample/quilt-04.png) ![sample05](http://swdyh.github.io/quilt/sample/quilt-05.png)

[![Build Status](https://travis-ci.org/swdyh/quilt.png?branch=master)](https://travis-ci.org/swdyh/quilt)

A Ruby library for generating identicon.

Identicon: http://en.wikipedia.org/wiki/Identicon

## Installation
Required rmagick or ruby-gd.

    gem install quilt

## Example

    # input: any string
    # output: 15 * 15 png (default)
    identicon = Quilt::Identicon.new 'sample'
    identicon.write 'sample15_15.png'

    # input: identicon code(32 bit integer)
    # output: 15 * 15 png (default)
    identicon = Quilt::Identicon.new 1, :type => :code
    identicon.write 'sample15_15_code.png'

    # input: ip address
    identicon = Quilt::Identicon.new '100.100.100.100', :type => :ip
    identicon.write 'sample15_15_ip.png'

    # output: 150 * 150 png
    identicon = Quilt::Identicon.new 'sample', :scale => 10
    identicon.write 'sample150_150.png'

    # output: blob
    identicon = Quilt::Identicon.new 'sample'
    print identicon.to_blob

    # change image library to Rmagick to  GD
    Quilt::Identicon.image_lib = Quilt::ImageGD
    identicon = Quilt::Identicon.new 'sample'
    identicon.write 'sample15_15_gd.png'

## Information

Copyright (c) 2008 swdyh
The MIT License
https://github.com/swdyh/quilt
