require 'wall_builder'
describe WallBuilder do
  describe "#make_wall" do
    it "should place two 1920x1200 images alongside each other" do
      im_one = mock("1920x1200")
      im_two = mock("1920x1200")
      target = mock("target")
      [im_one, im_two].each do  |im|
        im.stub!(:columns).and_return(1920)
        im.stub!(:rows).and_return(1200)
      end

      ImageList.should_receive(:new).once.with("42").and_return(im_one)
      ImageList.should_receive(:new).once.with("39").and_return(im_two)
      Image.should_receive(:new).once.with(3840, 1200).and_return(target)

      wall_builder = WallBuilder.new
      wall_builder.should_receive(:place_onto).once.with(0, 0, im_one, target)
      wall_builder.should_receive(:place_onto).once.with(1920, 0, im_two, target)
      target.should_receive(:write).once.with("42 and 39.jpg")

      wall_builder.make_wall("42", "39")
    end
  end
end
