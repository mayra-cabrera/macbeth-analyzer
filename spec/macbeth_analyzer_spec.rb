require './lib/macbeth_analyzer'

describe MacbethAnalyzer do

  describe "initialize" do
    before(:each) do
      @analyzer = MacbethAnalyzer.new
    end

    it "should initialize a nokogiri document" do
      expect(@analyzer.doc).to be_a_kind_of(Nokogiri::HTML::Document)
    end
    
    it "should set character list as an empty array" do
      expect(@analyzer.speakers).to eq([])
    end

    it "should set number of lines as an empty hash" do
      expect(@analyzer.number_of_lines).to eq({})
    end
  end

  describe "#search_for_speakers" do
    before(:all) do
      @analyzer = MacbethAnalyzer.new
      @analyzer.search_for_speakers
    end

    it "should search for macbeth characters" do
      expect(@analyzer.speakers).to_not be_empty
    end

    it "should remove ALL entry from list" do
      expect(@analyzer.speakers.include? "ALL").to be_falsy
    end
  end

  describe "#count_lines_for_speakers" do
    before(:all) do
      @analyzer = MacbethAnalyzer.new
      @analyzer.search_for_speakers
      @analyzer.count_lines_for_speakers
    end

    it "should set number of lines per character" do
      @analyzer.speakers.each do |speaker|
        expect(@analyzer.number_of_lines[speaker]).to_not be_nil
      end
    end
  end
end


