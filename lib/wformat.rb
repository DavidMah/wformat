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

  opts.on('--width=WIDTH', Integer, 'Monitor Width') do |width|
    options['width'] = width
  end

  opts.on('--height=HEIGHT', Integer, 'Monitor Height') do |height|
    options['height'] = height
  end

  opts.on('--title=TITLE', "Output filename") do |title|
    options['title'] = title
  end

  opts.on('--color=COLOR', "Backdrop color") do |color|
    options['color'] = color
  end

  opts.on('--trace', "Provide stack trace when error occurs") do
    options['trace'] = true
  end
end

begin
  optparse.parse!
  help_message if ARGV.empty?

  # parse command out from the arguments
  command   = ARGV.shift
  arguments = ARGV << options

  interface = WallInterface.new
  interface.run(command, arguments)
rescue => ex
  if options['trace']
    puts "#{ex.inspect}"
  else
    puts "There was an error! Add the --trace switch for the stack trace"
  end
  puts opts_banner
  exit
end
