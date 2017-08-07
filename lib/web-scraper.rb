class WebScraper
  attr_accessor :language, :phrase, :url

  # initialize new web scraper for a language and phrase
  def initialize(language, phrase)
    @language = language
    @phrase = phrase
    @language.phrases << @phrase
    @url = self.url
    @language.urls << @url unless @language.urls.include?(@url)
  end

  def url
    parsed_phrase = @phrase.split(" ").join("%20").gsub(/[^0-9a-z [%20]]/i, '')
    code = @language.code
    "https://translate.google.com/#en/#{code}/#{parsed_phrase}"
  end

  def scrape
    html = open(@url)
    doc = Nokogiri::HTML(html)
    binding.pry
    doc.css('#result_box span').text
  end

  #scrape_details method
    # pulls detailed translation/alternate translations for given language
  # scraper pulls google's language code from language hash
end
