module RosettaSearch
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

    # create url
    def url
      "http://www.wordreference.com/#{@language.wordrefy}/#{@word}"
    end

    # scrape wordreference for details
    def scrape
      # check if url exists, i.e. if language exists on wordreference
      if @url != nil
        html = open(@url)
        doc = Nokogiri::HTML(html)
        puts "-------------------"
        top_translation = doc.css('.WRD:first-of-type')
        # word in english
        puts "Your word: #{top_translation.css('.even:first-of-type .FrWrd strong').text}".cyan
        # part of speech in english
        puts top_translation.css('.even:first-of-type .FrWrd em span').text.cyan
        # meaning of word (sometimes in both languages)
        puts "Meaning:#{top_translation.css('.even:first-of-type .FrWrd + td').text}".cyan
        # translation in target language
        puts "Translation in #{@language.name.capitalize}: #{top_translation.css('.even:first-of-type .ToWrd').text}".cyan
        # example of word in sentence in english
        en_examples = top_translation.css('.FrEx').text.split(/\?|\.|\!/)
        puts "------"
        puts "Example sentence in English: #{en_examples[0]}.".cyan unless en_examples == nil
        # example of word in sentence in target language
        lg_examples = top_translation.css('.ToEx:not(.tooltip)').text.split(/\?|\.|\。|\!|\！|\？/)
        puts "Example sentence in #{@language.name.capitalize}: #{lg_examples[0]}.".cyan unless lg_examples == nil
      else
        # alert user if language cannot be found on wordreference
        puts "We cannot find examples for that particular expression/language.".yellow
      end
    end

  end

  WR = ["spanish", "french", "german", "italian", "dutch", "swedish",
  "russian", "portuguese", "polish", "romanian", "turkish",
  "chinese", "japanese", "korean", "arabic", "greek", "czech"]
end
