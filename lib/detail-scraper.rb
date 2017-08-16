class DetailScraper
  attr_accessor :language, :word, :url

  # initialize new web scraper for a language and phrase
  def initialize(language, word)
    @language = language
    @word = word
    # create wordreference url if wordreference has language
    if WR.include?(@language.name)
      @url = self.url
    end
  end

  def url
    "http://www.wordreference.com/#{@language.wordrefy}/#{@word}"
  end

  def scrape
    if @url != nil
      html = open(@url)
      doc = Nokogiri::HTML(html)
      puts "-------------------"
      puts "Your word: " + doc.css('.WRD:first-of-type .even:first-of-type .FrWrd strong').text + ", " + doc.css('.WRD:first-of-type .even:first-of-type .FrWrd em span').text
      puts "Meaning:" + doc.css('.WRD:first-of-type .even:first-of-type .FrWrd + td').text
      puts "Translation in #{@language.name.capitalize}: " + doc.css('.WRD:first-of-type .even:first-of-type .ToWrd').text
      en_examples = doc.css('.WRD:first-of-type .FrEx').text.split(".")
      puts "------"
      puts "Example sentence in English: " + "#{en_examples[0]}." unless en_examples == nil
      lg_examples = doc.css('.WRD:first-of-type .ToEx').text.split(/\?|\.|\。|\!|\！|\？/)
      puts "Example sentence in #{@language.name.capitalize}: " + "#{lg_examples[0]}." unless lg_examples == nil
    else
      puts "We cannot find examples for that particular language."
    end
  end

end

WR = ["spanish", "french", "german", "italian", "dutch", "swedish",
"russian", "portuguese", "polish", "romanian", "turkish",
"chinese", "japanese", "korean", "arabic", "greek", "czech"]
