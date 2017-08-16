class Stone
  @@all = []
  attr_accessor :langs, :lang1, :lang2, :lang3, :lang4

  # create a new language stone
  def initialize(lang1, lang2 = nil, lang3 = nil, lang4 = nil)
    @langs = []
    @lang1 = find_or_create_language(lang1)
    @lang2 = find_or_create_language(lang2) unless lang2 == nil
    @lang3 = find_or_create_language(lang3) unless lang3 == nil
    @lang4 = find_or_create_language(lang4) unless lang4 == nil
    @langs << @lang1
    @langs << @lang2 unless lang2 == nil
    @langs << @lang3 unless lang3 == nil
    @langs << @lang4 unless lang4 == nil
    @@all << self
  end

  # find_or_create_language
  def find_or_create_language(lang_name)
    Language.find_or_create(lang_name)
  end

  # translate phrase into each language and print to console
  def translate(phrase)
    puts "-------------------"
    puts ""
    @langs.each do |lang|
      lang.phrases << phrase
      translation = Google_Stuff::TRANSLATOR.translate phrase, to: lang.code
      puts "#{lang.name.capitalize}: #{translation}"
    end
  end

  # list all language stones that have been created
  def self.all
    @@all
  end

end
