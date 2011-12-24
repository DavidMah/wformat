require 'wall_merger.rb'
require 'wall_scaler.rb'

class WallInterface
  BUILDERS = {"merge" => WallMerger,
              "scale" => WallScaler}
  def run(command, arguments)
    BUILDERS[command].new.send(command, *arguments)
  end
end
