# wall_merger.rb
require 'RMagick'
require 'wall_operations'
include Magick

class WallMerger
  include WallOperations

  def merge(image_one, image_two, options = {})
    width_one  = options['width_one']  || 1920
    width_two  = options['width_two']  || 1920
    height_one = options['height_one'] || 1200
    height_two = options['height_two'] || 1200
    color      = options['color']      || 'black'
    title      = options['title']      || "#{File.basename(image_one, File.extname(image_one))} and #{File.basename(image_two, File.extname(image_two))}.jpg"

    # prepare image will retrieve the image and scale it
    im_one = prepare_image(image_one, width_one, height_one)
    im_two = prepare_image(image_two, width_two, height_two)
    result = prepare_backdrop({'width_one'  => width_one,
                               'width_two'  => width_two,
                               'height_one' => height_one,
                               'height_two' => height_two,
                               'color'      => color})

    # place through will drop the image onto the target with shifting
    place_through(0, 0, width_one, height_one, im_one, result)
    place_through(width_one, 0, width_two, height_two, im_two, result)

    save_image(result, title)
  end
end
