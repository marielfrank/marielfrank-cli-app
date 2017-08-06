class Language
  @@all = []
  attr_accessor :name, :code, :urls, :phrases

  def initialize
    @phrases = []
    @urls = []
    @@all << self
  end

  # list all languages that have been created
  def self.all
    @@all
  end

  def self.find_or_create(lang_name)
    # search @@all for self
    # if exist, return self
    # otherwise, self.new, search LANGUAGES hash and set code
    # return self
  end
end

LANGUAGES = {}
# hash of languages & codes (https://cloud.google.com/translate/docs/languages)
