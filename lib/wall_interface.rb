require 'wall_merger.rb'

class WallInterface
  def merge(arguments)
    WallMerger.new.merge(*arguments)
  end
end
