class Language
  @@all = []
  attr_accessor :name, :code, :phrases

  def initialize
    @phrases = []
    @@all << self
  end

  # turn name into symbol
  def symbolize
    @name.split(" ").join("_").to_sym
  end

  # list all languages that have been created
  def self.all
    @@all
  end

  # create by name
  def self.create(lang_name)
    new_lang = self.new
    new_lang.name = lang_name
    new_lang.code = Google_Stuff::LANGUAGES[new_lang.symbolize]
    new_lang
  end

  # find or create by name
  def self.find_or_create(lang_name)
    found = @@all.detect {|lang| lang.name == lang_name}
    if found == nil
      self.create(lang_name)
    else
      found
    end
  end

  # get wordreference code
  def wordrefy
    if @name == "czech"
      "encz"
    elsif @name == "greek"
      "engr"
    else
      "en#{@code}"
    end
  end

end
