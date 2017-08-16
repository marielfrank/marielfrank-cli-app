class Translator
  attr_accessor :language_count, :stone, :lang1_pick, :lang2_pick, :lang3_pick, :lang4_pick, :phrase

  # pick how many languages for translation
  def pick_a_number
    puts "Please choose a number between 1 and 4."
    @language_count = gets.strip.to_i # turn string to integer
    if @language_count < 1 || @language_count > 4 # make sure number is within range
      pick_a_number
    end
  end

  # list languages available for translation through Google Cloud Translation API
  def list_languages
    string = ""
    Google_Stuff::LANGUAGES.each do |lang, code|
      string << "#{lang.to_s.capitalize}, "
    end
    puts string.gsub(/, $/, "").gsub("_", " ")
  end

  # reset languages and choose new ones
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
    elsif @language_count > 1
      puts "Now choose your second language:"
      @lang2_pick = gets.strip.downcase
    end
    puts "You'll be translating '#{phrase}' into:"
    # list languages picked for translation
    [@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick].each {|lang| puts lang.capitalize if lang != nil}
    # create new language stone from picked languages
    @stone = Stone.new(@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick)
  end

  # set new phrase for translation
  def set_phrase
    puts "Please enter the phrase that you would like to translate:"
    @phrase = gets.strip
    puts "Excellent."
  end

  # primary CLI method
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

  # continued menu options are presented once first translation is complete
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
