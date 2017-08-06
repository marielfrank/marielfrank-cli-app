class WebScraper
  attr_accessor :language, :phrase

  def initialize(language, phrase)
    @language = language
    @phrase = phrase
  end

  #scrape method
    # uses open-uri & nokogiri
    # gets translation for phrase in given language
  #scrape_details method
    # pulls detailed translation/alternate translations for given language
  # scraper pulls google's language code from language hash
end
