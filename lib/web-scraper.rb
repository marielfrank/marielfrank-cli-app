class WebScraper
  attr_accessor :language, :phrase, :url

  # initialize new web scraper for a language and phrase
  def initialize(language, phrase)
    @language = language
    @phrase = phrase
  end

  #scrape method
    # uses open-uri & nokogiri
    # gets translation for phrase in given language
  def scrape
    parsed_phrase = @phrase.split(" ").join("%20")
    code = LANGUAGES[language.to_sym]
    @url = "https://translate.google.com/#en/#{code}/#{parsed_phrase}"
    html = open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36")
    doc = Nokogiri::HTML(html)
    doc.css('#result_box span')
  end
  #scrape_details method
    # pulls detailed translation/alternate translations for given language
  # scraper pulls google's language code from language hash
end
