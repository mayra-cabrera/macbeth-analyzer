require 'open-uri'
require 'nokogiri'
require 'pry'

class MacbethAnalyzer 
  attr_reader :doc, :speakers, :number_of_lines

  def initialize
    @doc = Nokogiri::HTML(open(biblio_url))
    @speakers = []
    @number_of_lines = {}
  end

  def run
    search_for_speakers
    count_lines_for_speakers
    print_results
  end

  def search_for_speakers
    @speakers = speakers_from_biblio.uniq! 
    @speakers -= ["ALL"]
  end

  def count_lines_for_speakers
    @speakers.each do |speaker|
      lines = @doc.xpath("//speech//speaker[contains(text(), '#{speaker}')]").count     
      @number_of_lines[speaker] = lines
    end
  end

  def print_results
    @number_of_lines.each do |speaker, lines|
      p "#{lines} #{speaker}"
    end
  end

  private

  def biblio_url
    "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  end

  def speakers_from_biblio
    @doc.css("speech speaker").map(&:text)
  end 
end

analyzer = MacbethAnalyzer.new
analyzer.run
