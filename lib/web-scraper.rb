class WebScraper
  attr_accessor :language, :phrase

  def initialize(language, phrase)
    @language = language
    @phrase = phrase
  end
end
