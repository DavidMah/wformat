#!/usr/bin/env ruby
require 'optparse'
require 'wall_interface'

opts_banner = ""
options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: wformat command [options] arguments"
  opts_banner = opts.banner

  opts.on('-h', '--help', 'Display This Screen') do
    puts "wformat is a command line utility to format images as computer wallpapers"
    puts "commands:\n  merge"
    puts opts
    exit
  end

  opts.on('--widthone=WIDTH', Integer, 'Left Monitor WIDTH') do |width|
    options['width_one'] = width
  end

  opts.on('--widthtwo=WIDTH', Integer, 'Right Monitor WIDTH') do |width|
    magic << self
    options['width_two'] = width
  end

  opts.on('--heightone=HEIGHT', Integer, 'Left Monitor HEIGHT') do |height|
    options['height_one'] = height
  end

  opts.on('--heighttwo=HEIGHT', Integer, 'Right Monitor HEIGHT') do |height|
    options['height_two'] = height
  end

  opts.on('--title=TITLE', "Output filename") do |title|
    options['title'] = title
  end
end

begin
  optparse.parse!
  help_message if ARGV.empty?
  command   = ARGV.shift
  arguments = ARGV << options

  interface = WallInterface.new
  interface.send(command, arguments)
rescue => ex
  puts opts_banner
  exit
end
