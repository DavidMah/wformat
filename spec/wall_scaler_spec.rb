require 'wall_scaler'

def stub_size(im, width, height)
  im.stub!(:columns).and_return(width)
  im.stub!(:rows).and_return(height)
end

def setup(options = [])
  stub_size(@image, 1920, 1200)                                                            if options.include? 'images'
  @wall_scaler.should_receive(:prepare_backdrop).once.with(1920, 1200).and_return(@target) if options.include? 'size'
  @wall_scaler.should_receive(:place_onto).once.with(0, 0, @image, @target)                if options.include? 'place'
  @wall_scaler.should_receive(:save_image).once.with(@target, "42 scaled.jpg")             if options.include? 'write'
end

describe WallScaler do
  before :each do
    @image = mock('image')
    @wall_scaler = WallScaler.new
    @wall_scaler.should_receive(:prepare_image).once.with("42", anything, anything).and_return(@image)
  end


  describe "#scale" do

    it 'should keep one 1920x1200 image the same' do
      setup(['images', 'size', 'place', 'write'])
      @wall_scaler.scale("42")
    end

    it "should rightward shift thin images" do
      setup(['size', 'write'])
      stub_size(@image, 1520, 1200)
      @wall_scaler.should_receive(:place_onto).once.with(200, 0, @image, @target)
      @wall_scaler.scale("42")
    end

    it "should downward shift short images" do
      setup(['size', 'write'])
      stub_size(@image, 1920, 1000)
      @wall_scaler.should_receive(:place_onto).once.with(0, 100, @image, @target)
      @wall_scaler.scale("42")
    end

    it "should rightward shift a small and short image" do
      setup(['size', 'write'])
      stub_size(@image, 1920, 960)
      @wall_scaler.should_receive(:place_onto).once.with(0, 120, @image, @target)
      @wall_scaler.scale("42")
    end

    it "should use the client requested filename" do
      setup(['images', 'size', 'place'])
      @wall_scaler.should_receive(:save_image).once.with(@target, "garpley_title")
      @wall_scaler.scale("42", {'title' => "garpley_title"})
    end

  end
end
