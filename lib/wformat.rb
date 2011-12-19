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
end

optparse.parse!

interface = WallInterface.new

command   = ARGV.shift
arguments = ARGV

interface.send(command, *arguments)
