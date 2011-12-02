# wall_builder.rb

require 'RMagick'
include Magick

class WallBuilder
  def makewall(image_one, image_two)
    input = ImageList.new(image_one, image_two)
    output = input.montage { self.geometry = Magick::Geometry.new(1920,1200,0,0) }
    output.write(File.basename(image_one,".jpg") + "&" + File.basename(image_two,".jpg") + ".jpg")
    output.display
  end
end
