require 'wall_operations'
class Wall
  include WallOperations
end

def stub_size(im, width, height)
  im.stub!(:columns).and_return(width)
  im.stub!(:rows).and_return(height)
end

describe WallOperations do

  before :each do
    @image = mock("42")
    @wall  = Wall.new
  end

  describe "#prepare_image" do
    it "should use the returned scale factor" do
      ImageList.should_receive(:new).once.with("42").and_return(@image)
      @wall.should_receive(:get_scaled_size).once.with(@image, 1000, 1000).and_return(39)
      @image.should_receive(:scale!).once.with(39)
      @wall.prepare_image("42", 1000, 1000).should == @image
    end
  end

  describe "#get_scaled_size" do
    it "should return 1.0 for a cleanly filling image" do
      stub_size(@image, 1000, 1000)
      @wall.get_scaled_size(@image, 1000, 1000).should == 1.0
    end

    it "should return 1.0 if the height fills" do
      stub_size(@image, 39, 1000)
      @wall.get_scaled_size(@image, 1000, 1000).should == 1.0
    end

    it "should return 1.0 if the width fills" do
      stub_size(@image, 1000, 39)
      @wall.get_scaled_size(@image, 1000, 1000).should == 1.0
    end

    it "should use a multiplier from filling the width (to avoid overflow)" do
      stub_size(@image, 200, 100)
      @wall.get_scaled_size(@image, 1000, 1000).should == 5.0
    end

    it "should use a multiplier frmo filling the height (to avoid overflow)" do
      stub_size(@image, 100, 200)
      @wall.get_scaled_size(@image, 1000, 1000).should == 5.0
    end

    it "should scale downwards" do
      stub_size(@image, 2000, 4000)
      @wall.get_scaled_size(@image, 1000, 1000).should == 0.25
    end
  end

  # Because the code is so closely linked to the method call through RMagick(A block!)
  # This test relies on RMagick
  describe "#get_backdrop" do
    it "should return an image with the given bounds with good defaults" do
      result = @wall.prepare_backdrop({'width' => 50, 'height' => 50})
      result.columns.should == 50
      result.rows.should    == 50
      result.background_color.should == 'black'
    end

    it "should add the two widths together" do
      result = @wall.prepare_backdrop({'width_one' => 50,
                                       'width_two' => 75})
      result.columns.should == 125
    end

    it "should use the larger of the two heights" do
      heights = {'height_one' => 42, 'height_two' => 39}
      @wall.prepare_backdrop(heights).rows.should == 42
      heights = {'height_two' => 42, 'height_one' => 39}
      @wall.prepare_backdrop(heights).rows.should == 42
    end

    it "should use the color given" do
      # RMagick seems to convert to the word when I use such a clean hexcode
      @wall.prepare_backdrop({'color' => '#ffffff'}).background_color.should == 'white'
      @wall.prepare_backdrop({'color' => '#ddaa00'}).background_color.should == '#DDDDAAAA0000'
    end
  end

  describe "#place_through" do
    before :each do
      @target = mock('39')
    end

    it 'should rightward shift a too thin image' do
      stub_size(@image, 300, 1000)
      @wall.should_receive(:place_onto).once.with(350, 0, @image, @target)
      @wall.place_through(0, 0, 1000, 1000, @image, @target)
    end

    it 'should downward shift a too short image' do
      stub_size(@image, 1000, 300)
      @wall.should_receive(:place_onto).once.with(0, 350, @image, @target)
      @wall.place_through(0, 0, 1000, 1000, @image, @target)
    end

    it "should shift and use the given offset" do
      stub_size(@image, 300, 1000)
      @wall.should_receive(:place_onto).once.with(450, 0, @image, @target)
      @wall.place_through(100, 0, 1000, 1000, @image, @target)
    end
  end
end
