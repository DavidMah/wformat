Gem::Specification.new do |g|
  g.name        = 'wformat'
  g.version     = '0.1.0'
  g.executables << 'wformat'
  g.date        = '2011-12-01'
  g.summary     = "wformat is a command line utility to format images as computer wallpapers"
  g.description     = "wformat is a command line utility to format images as computer wallpapers"

  g.authors  = ["David Mah", "Conner Stenerson"]
  g.email    = "mahhaha@gmail.com"
  g.files    = ["lib/wformat.rb", "lib/wall_builder.rb"]
  g.homepage = "https://github.com/DavidMah/wformat"
  g.add_runtime_dependency 'rmagick', '~> 2.13'
end
