require 'wall_dupe_finder'

describe WallDupeFinder do
  before :each do
    @wall = WallDupeFinder.new
  end

  describe "#get_images" do
    it "should report a file as itself" do
      File.should_receive(:file?).once.with('42.jpg').and_return(true)
      @wall.get_images("42.jpg").should == ['./42.jpg']
    end

    it "won't respond with non image files" do
      File.should_receive(:file?).once.with('42.derp').and_return(true)
      @wall.get_images("42.derp").should == []
    end

    it "should follow all files in given directory except those starting with ." do
      ['42', '3'].each { |dir| File.should_receive(:file?).once.with(dir).and_return(false) }
      ['1.gif', '2.jpg', '4.png'].each { |fi| File.should_receive(:file?).once.with(fi).and_return(true) }
      Dir.should_receive(:entries).once.with('42').and_return(['1.gif', '2.jpg', '3', '.', '..', '.vim'])
      Dir.should_receive(:entries).once.with('3').and_return(['4.png'])

      @wall.get_images("42").should == ['./42/1.gif', './42/2.jpg', './42/3/4.png']
    end
  end

  describe "#hash_images" do

  end

  describe "#extract_dupes" do

  end

  describe "#report_dupes" do

  end

end
