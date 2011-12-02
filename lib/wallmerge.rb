#!/usr/bin/env ruby
require 'optparse'
require 'wall_builder.rb'

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: wallmerge [options] image1 image2"

  opts.on('-h', '--help', 'Display This Screen') do
    puts opts.banner
    exit
  end
end

optparse.parse!

wall_builder = WallBuilder.new
wall_builder.construct(*ARGV)
