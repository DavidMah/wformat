# wall_merger.rb
require 'RMagick'
include Magick

class WallMerger
  def merge(image_one, image_two, options = {})
    width_one  = options['width_one']  || 1920
    width_two  = options['width_two']  || 1920
    height_one = options['height_one'] || 1200
    height_two = options['height_two'] || 1200
    title      = options['title']      || "#{File.basename(image_one, ".jpg")} and #{File.basename(image_two, ".jpg")}.jpg"

    im_one = prepare_image(image_one, width_one, height_one)
    im_two = prepare_image(image_two, width_two, height_two)


    result = Image.new(width_one + width_two, [height_one, height_two].max)
    place_through(0, 0, width_one, height_one, im_one, result)
    place_through(width_one, 0, width_two, height_two, im_two, result)

    result.write(title)
  end

  # Minimally scales image to fill width_bound and height_bound. Will not overflow bounds
  def prepare_image(image_name, width_bound, height_bound)
    im = ImageList.new(image_name)
    scale_factor = get_scaled_size(im, width_bound, height_bound)
    puts "scale factor #{scale_factor}"
    im.scale!(scale_factor)
  end

  # Returns a scale factor for the image with the given bounds
  def get_scaled_size(image, width_bound, height_bound)
    width_multiplier  = 1.0 * width_bound / image.columns
    height_multiplier = 1.0 * height_bound / image.rows

    if image.rows * width_multiplier <= height_bound
      width_multiplier
    else
      height_multiplier
    end
  end

  # Places image on target, also applying rightward or downward shift to given coordinates based on bounds
  def place_through(x, y, width_bound, height_bound, image, target)
    new_x = (width_bound  - image.columns) / 2 + x
    new_y = (height_bound - image.rows)    / 2 + y
    place_onto(new_x, new_y, image, target)
  end

  # Places image on target where top left corner of image goes to x and y coordinates
  def place_onto(x, y, image, target)
    target.import_pixels(x, y, image.columns, image.rows, 'RGB', image.export_pixels)
  end
end
