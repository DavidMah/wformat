#!/usr/bin/env ruby
require 'optparse'
require 'wall_interface'

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: wformat [options] image1 image2"

  opts.on('-h', '--help', 'Display This Screen') do
    puts opts.banner
    exit
  end

  opts.on('--widthone WIDTH', Integer, 'Left Monitor WIDTH') do |width|
    options['width_one'] = width
  end

  opts.on('--widthtwo WIDTH', Integer, 'Right Monitor WIDTH') do |width|
    options['width_two'] = width
  end

  opts.on('--heightone HEIGHT', Integer, 'Left Monitor HEIGHT') do |height|
    options['height_one'] = height
  end

  opts.on('--heighttwo HEIGHT', Integer, 'Right Monitor HEIGHT') do |height|
    options['height_two'] = height
  end
end

optparse.parse!

interface = WallInterface.new

command   = ARGV.shift
arguments = ARGV << options

interface.send(command, arguments)
