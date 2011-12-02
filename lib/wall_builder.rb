# wall_builder.rb

require 'RMagick'
include Magick

class WallBuilder
  def make_wall(image_one, image_two)
    im_one = ImageList.new(image_one)
    im_two = ImageList.new(image_two)

    result = Image.new(3840, 1200)
    place_onto(0, 0, im_one, result)
    place_onto(1920, 0, im_two, result)

    result.write(File.basename(image_one,".jpg") + " and " + File.basename(image_two,".jpg") + ".jpg")
  end

  def place_onto(x, y, image, target)
    target.import_pixels(x, y, image.columns, image.rows, 'RGB', image.export_pixels)
  end
end
