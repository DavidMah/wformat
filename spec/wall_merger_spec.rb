require 'wall_merger'

def stub_size(im, width, height)
  im.stub!(:columns).and_return(width)
  im.stub!(:rows).and_return(height)
end

def setup(options = [])
  [@im_one, @im_two].each {|im| stub_size(im, 1920, 1200) }                      if options.include? 'images'
  @wall_merger.should_receive(:prepare_backdrop).once.with({'width_one'  => 1920,
                                                            'width_two'  => 1920,
                                                            'height_one' => 1200,
                                                            'height_two' => 1200,
                                                            'color'      => 'black'}).and_return(@target) if options.include? 'size'
  @wall_merger.should_receive(:place_through).once.with(0,    0, 1920, 1200, @im_one, @target)    if options.include? 'place'
  @wall_merger.should_receive(:place_through).once.with(1920, 0, 1920, 1200, @im_two, @target) if options.include? 'place'
  @wall_merger.should_receive(:save_image).once.with(@target, "42 and 39.jpg")    if options.include? 'write'
end

describe WallMerger do

  before :each do
    @im_one = mock("im1")
    @im_two = mock("im2")
    @target = mock("target")
    @wall_merger = WallMerger.new
    @wall_merger.should_receive(:prepare_image).once.with("42", anything, anything).and_return(@im_one)
    @wall_merger.should_receive(:prepare_image).once.with("39", anything, anything).and_return(@im_two)
  end
  describe "#merge" do
    it "should place two 1920x1200 images alongside each other" do
      setup(['images', 'size', 'place', 'write'])

      @wall_merger.merge("42", "39")
    end

    it "should place two 1000x1000 images alongside each other" do
      setup(['write'])
      [@im_one, @im_two].each { |im| stub_size(im, 1000, 1000) }
      @wall_merger.should_receive(:prepare_backdrop).once.with({'width_one'  => 1000,
                                                                'width_two'  => 1000,
                                                                'height_one' => 1000,
                                                                'height_two' => 1000,
                                                                'color'      => 'black'}).and_return(@target)
      @wall_merger.should_receive(:place_through).once.with(0,    0, 1000, 1000, @im_one, @target)
      @wall_merger.should_receive(:place_through).once.with(1000, 0, 1000, 1000, @im_two, @target)
      @wall_merger.merge("42", "39", {'width_one' => 1000, 'width_two' =>1000, 'height_one' => 1000, 'height_two' => 1000})
    end

    it "should use the client requested filename" do
      setup(['images', 'size', 'place'])
      @wall_merger.should_receive(:save_image).once.with(@target, "garpley_title")
      @wall_merger.merge("42", "39", {'title' => "garpley_title"})
    end
  end
end
