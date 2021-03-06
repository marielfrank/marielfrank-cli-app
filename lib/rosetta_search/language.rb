class RosettaSearch::Language
  @@all = []
  attr_accessor :name, :code

  # new language adds self to all languages created
  def initialize
    @@all << self
  end

  # list all languages that have been created
  def self.all
    @@all
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

  # create by name
  def self.create(lang_name)
    new_lang = self.new
    new_lang.name = lang_name
    new_lang.code = RosettaSearch::LANGUAGES[new_lang.symbolize]
    new_lang
  end

  # turn name into symbol for searching Google language hash
  def symbolize
    @name.split(" ").join("_").to_sym
  end

  # get wordreference code for detail scraping
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
