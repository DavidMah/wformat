# wall_scaler.rb
require 'RMagick'
require 'wall_operations'
include Magick

class WallScaler
  include WallOperations

  def scale(image, options = {})
    width  = options['width']  || 1920
    height = options['height'] || 1200

    title  = options['title']  || "#{File.basename(image, ".jpg")} scaled.jpg"

    im = prepare_image(image, width, height)
    result = prepare_backdrop(width, height)

    place_through(0, 0, width, height, im, result)
    save_image(result, title)
  end
end
