Gem::Specification.new do |g|
  g.name        = 'wformat'
  g.version     = '0.3.0'
  g.executables << 'wformat'
  g.date        = '2011-12-01'
  g.summary     = "wformat is a command line utility to format images as computer wallpapers"
  g.description     = "wformat is a command line utility to format images as computer wallpapers. It can horizontally merge two images together with the `merge` command, and it can scale an image to another size with the `scale` command"

  g.authors  = ["David Mah"]
  g.email    = "mahhaha@gmail.com"
  g.files    = ["lib/wformat.rb", "lib/wall_interface.rb",
                "lib/wall_operations.rb",
                "lib/wall_merger.rb", "lib/wall_scaler.rb"]
  g.homepage = "https://github.com/DavidMah/wformat"
  g.add_runtime_dependency 'rmagick', '~> 2.13'
end
