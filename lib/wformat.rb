#!/usr/bin/env ruby
require 'optparse'
require 'wall_builder'

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: wformat [options] image1 image2"

  opts.on('-h', '--help', 'Display This Screen') do
    puts opts.banner
    exit
  end
end

optparse.parse!

wall_builder = WallBuilder.new
wall_builder.make_wall(*ARGV)
