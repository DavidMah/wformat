# wall_builder.rb

require 'RMagick'
include Magick

class WallBuilder
  def make_wall(image_one, image_two)
    input = ImageList.new(image_one, image_two)

    im_one = ImageList.new(image_one)
    im_two = ImageList.new(image_two)

    result = Image.new(3840, 1200)
    result.import_pixels(0, 0, im_one.columns, im_one.rows, 'RGB', im_one.export_pixels)
    result.import_pixels(1920, 0, im_two.columns, im_two.rows, 'RGB', im_two.export_pixels)

    result.write(File.basename(image_one,".jpg") + " and " + File.basename(image_two,".jpg") + ".jpg")
  end
end
