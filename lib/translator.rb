class Translator
  attr_accessor :language_count, :stone, :lang1_pick, :lang2_pick, :lang3_pick, :lang4_pick, :phrase

  def pick_a_number
    puts "Please choose a number between 1 and 4."
    @language_count = gets.strip.to_i
    if @language_count < 1 || @language_count > 4
      pick_a_number
    end
  end

  def list_languages
    string = ""
    Google_Stuff::LANGUAGES.each do |lang, code|
      string << "#{lang.to_s.capitalize}, "
    end
    puts string.gsub(/, $/, "").gsub("_", " ")
  end

  def pick_languages
    @lang1_pick = nil
    @lang2_pick = nil
    @lang3_pick = nil
    @lang4_pick = nil
    puts "What would you like your first language to be?"
    @lang1_pick = gets.strip.downcase
    if @language_count > 3
      puts "Now choose your second language:"
      @lang2_pick = gets.strip.downcase
      puts "And your third language:"
      @lang3_pick = gets.strip.downcase
      puts "And finally, your fourth language:"
      @lang4_pick = gets.strip.downcase
    elsif @language_count > 2
      puts "Now choose your second language:"
      @lang2_pick = gets.strip.downcase
      puts "And your third language:"
      @lang3_pick = gets.strip.downcase
      # binding.pry
    elsif @language_count > 1
      puts "Now choose your second language:"
      @lang2_pick = gets.strip.downcase
    end
    puts "You'll be translating '#{phrase}' into:"

    [@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick].each {|lang| puts lang.capitalize if lang != nil}
    @stone = Stone.new(@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick)
  end

  def set_phrase
    puts "Please enter the phrase that you would like to translate:"
    @phrase = gets.strip
    puts "Excellent."
  end

  def new_translation
    set_phrase if @phrase == nil
    puts "How many languages would you like for your translation?"
    pick_a_number
    puts "Great! Let's choose your language(s)."
    puts "If you'd like to see a list of languages available for translation, please enter 'list languages'. Otherwise, press 'Enter'."
    input = gets.strip
    list_languages if input == "list languages"
    pick_languages
    @stone.translate(@phrase)
    menu
  end

  def menu
    puts ""
    puts "-------------------"
    puts "To pick new languages, enter 'new languages',
    to translate a new phrase, enter 'new phrase',
    to get details/examples for a specific word, enter 'details',
    or to exit, please enter 'exit'."
    puts "-------------------"
    puts ""
    input = gets.strip
    case input
    when "new languages"
      new_translation
    when "new phrase"
      set_phrase
      @stone.translate(@phrase)
      menu
    when "details"
      puts "Which language would you like details for?"
      deet_lang = Language.find_or_create(gets.strip)
      puts "Great. Which word of '#{@phrase}' would you like further details on?"
      deet_word = gets.strip
      details = DetailScraper.new(deet_lang, deet_word)
      details.scrape
      menu
    when "exit"
      return
    end
  end

end

module Google_Stuff
  # Your Google Cloud Platform project ID
  project_id = "rosetta-search"

  # Instantiates a client
  TRANSLATOR = Google::Cloud::Translate.new(
    project: project_id,
    key: ENV["rosetta_key"]
  )

  # hash of languages & codes (https://cloud.google.com/translate/docs/languages)
  LANGUAGES = {
    afrikaans: "af",
    albanian: "sq",
    amharic: "am",
    arabic: "ar",
    armenian: "hy",
    azeerbaijani: "az",
    basque: "eu",
    belarusian: "be",
    bengali: "bn",
    bosnian: "bs",
    bulgarian: "bg",
    catalan: "ca",
    cebuano: "ceb",
    chinese: "zh",
    taiwanese: "zh-tw",
    corsican: "co",
    croatian: "hr",
    czech: "cs",
    danish: "da",
    dutch: "nl",
    english: "en",
    esperanto: "eo",
    estonian: "et",
    finnish: "fi",
    french: "fr",
    frisian: "fy",
    galician: "gl",
    georgian: "ka",
    german: "de",
    greek: "el",
    gujarati: "gu",
    haitian_creole: "ht",
    hausa: "ha",
    hawaiian: "haw",
    hebrew: "iw",
    hindi: "hi",
    hmong: "hmn",
    hungarian: "hu",
    icelandic: "is",
    igbo: "ig",
    indonesian: "id",
    irish: "ga",
    italian: "it",
    japanese: "ja",
    javanese: "jw",
    kannada: "kn",
    kazakh: "kk",
    khmer: "km",
    korean: "ko",
    kurdish: "ku",
    kyrgyz: "ky",
    lao: "lo",
    latin: "la",
    latvian: "lv",
    lithuanian: "lt",
    luxembourgish: "lb",
    macedonian: "mk",
    malagasy: "mg",
    malay: "ms",
    malayalam: "ml",
    maori: "mi",
    marathi: "mr",
    mongolian: "mn",
    myanmar: "my",
    nepali: "ne",
    norwegian: "no",
    nyanja: "ny",
    pashto: "ps",
    persian: "fa",
    polish: "pl",
    portuguese: "pt",
    punjabi: "pa",
    romanian: "ro",
    russian: "ru",
    samoan: "sm",
    scots_gaelic: "gd",
    serbian: "sr",
    sesotho: "st",
    shona: "sn",
    sindhi: "sd",
    sinhala: "si",
    slovak: "sk",
    slovenian: "sl",
    somali: "so",
    spanish: "es",
    sundanese: "su",
    swahili: "sw",
    swedish: "sv",
    tagalog: "tl",
    tajik: "tg",
    tamil: "ta",
    telugu: "te",
    thai: "th",
    turkish: "tr",
    ukrainian: "uk",
    urdu: "ur",
    uzbek: "uz",
    vietnamese: "vi",
    welsh: "cy",
    xhosa: "xh",
    yiddish: "yi",
    yoruba: "yo",
    zulu: "zu"
  }

end
