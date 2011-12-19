require 'wall_merger'

def stub_size(im, width, height)
  im.stub!(:columns).and_return(width)
  im.stub!(:rows).and_return(height)
end

def setup(options = [])
  @wall_merger.should_receive(:prepare_image).once.with("42", anything, anything).and_return(@im_one)
  @wall_merger.should_receive(:prepare_image).once.with("39", anything, anything).and_return(@im_two)

  [@im_one, @im_two].each {|im| stub_size(im, 1920, 1200) }                      if options.include? 'images'
  Image.should_receive(:new).once.with(3840, 1200).and_return(@target)           if options.include? 'size'
  @wall_merger.should_receive(:place_onto).once.with(0, 0, @im_one, @target)    if options.include? 'place'
  @wall_merger.should_receive(:place_onto).once.with(1920, 0, @im_two, @target) if options.include? 'place'
  @target.should_receive(:write).once.with("42 and 39.jpg")                      if options.include? 'write'
end

describe WallMerger do

  before :each do
    @im_one = mock("im1")
    @im_two = mock("im2")
    @target = mock("target")
    @wall_merger = WallMerger.new
  end
  describe "#merge" do
    it "should place two 1920x1200 images alongside each other" do
      setup(['images', 'size', 'place', 'write'])

      @wall_merger.merge("42", "39")
    end

    it "should place two 1000x1000 images alongside each other" do
      setup(['write'])
      [@im_one, @im_two].each { |im| stub_size(im, 1000, 1000) }
      Image.should_receive(:new).once.with(2000, 1000).and_return(@target)
      @wall_merger.should_receive(:place_onto).once.with(0, 0,    @im_one, @target)
      @wall_merger.should_receive(:place_onto).once.with(1000, 0, @im_two, @target)
      @wall_merger.merge("42", "39", {'width_one' => 1000, 'width_two' =>1000, 'height_one' => 1000, 'height_two' => 1000})
    end

    it "should use the client requested filename" do
      setup(['images', 'size', 'place'])
      @target.should_receive(:write).once.with("garpley_title")
      @wall_merger.merge("42", "39", {'title' => "garpley_title"})
    end

    it "should rightward shift thin images" do
      setup(['size', 'write'])
      stub_size(@im_one, 1520, 1200)
      stub_size(@im_two, 1760, 1200)
      @wall_merger.should_receive(:place_onto).once.with(200, 0,  @im_one, @target)
      @wall_merger.should_receive(:place_onto).once.with(2000, 0, @im_two, @target)
      @wall_merger.merge("42", "39")
    end

    it "should downward shift short images" do
      setup(['size', 'write'])
      stub_size(@im_one, 1920, 1000)
      stub_size(@im_two, 1920, 800)
      @wall_merger.should_receive(:place_onto).once.with(0, 100, @im_one, @target)
      @wall_merger.should_receive(:place_onto).once.with(1920, 200, @im_two, @target)
      @wall_merger.merge("42", "39")
    end

    it "should scale and shift overall small images" do
      setup(['size', 'write'])
      # original im_one, 192, 240. Scale factor = 5
      # original im_two, 96, 30. Scale factor = 20
      stub_size(@im_one, 960, 1200) # Scale is too Tall -- should rightward shift
      stub_size(@im_two, 1920, 600)  # Scale is too Wide -- should downward shift
      @wall_merger.should_receive(:place_onto).once.with(480, 0, @im_one, @target)
      @wall_merger.should_receive(:place_onto).once.with(1920, 300, @im_two, @target)
      @wall_merger.merge("42", "39")
    end
  end
end
