Gem::Specification.new do |g|
  g.name        = 'wformat'
  g.version     = '0.3.2'
  g.executables << 'wformat'
  g.date        = '2011-12-29'

  g.summary     = "wformat is a command line utility to organize collections of wallpapers"

  g.description =
    %Q[wformat is a command line utility to organize collections of wallpapers\n
    For now, it can only reformat images into proper sizes(for dualmonitors too)\n
    \n
    Soon it will feature organization through renaming and the ability to search for duplicates of images]


  g.authors  = ["David Mah"]
  g.email    = "mahhaha@gmail.com"
  g.files    = ["lib/wformat.rb", "lib/wall_interface.rb",
                "lib/wall_operations.rb",
                "lib/wall_merger.rb", "lib/wall_scaler.rb"]
  g.homepage = "https://github.com/DavidMah/wformat"
  g.add_runtime_dependency 'rmagick', '~> 2.13'
end
