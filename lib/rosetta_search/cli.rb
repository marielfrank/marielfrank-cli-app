class RosettaSearch::CLI
  attr_accessor :language_count, :stone, :lang1_pick, :lang2_pick,
    :lang3_pick, :lang4_pick, :phrase, :greeted, :valid_languages

  def initialize(greeted = false)
    @greeted = greeted
  end

  # greet user
  def greet
    # welcome message
    puts "Welcome to Rosetta Search!"
    puts "You can translate from English into several languages at once :)"
    # change @greeted to true
    @greeted = true
  end

  # pick how many languages for translation
  def pick_a_number
    puts "Please choose a number between 1 and 4."
    # turn string to integer
    @language_count = gets.strip.to_i
    # make sure number is within range
    if @language_count < 1 || @language_count > 4
      pick_a_number
    end
  end

  # create list of languages available for translation through Google Cloud Translation API
  def valid_languages
    Google_Stuff::LANGUAGES.map do |lang, code|
      lang.to_s.capitalize.gsub("_", " ")
    end
  end

  # list languages
  def list_languages
    puts self.valid_languages.join(", ")
  end

  # check if language is valid
  def valid_language?(language)
    self.valid_languages.include?(language.capitalize)
  end

  # set language
  def set_language
    # get input from user
    input = gets.strip.downcase
    # check if the input is a valid language
    if valid_language?(input)
      # set the language if valid
      language_pick = input
    else
      # error message
      puts "Oops! Looks like we don't have that language. Please enter a language from our list."
      # option to see full language list again
      puts "You can enter 'list languages' to see the full list again."
      list_languages if gets.strip == "list languages"
      # try setting the language again
      set_language
    end
    # return the language name that we picked
    language_pick
  end

  # reset languages and choose new ones
  def pick_languages
    @lang1_pick = nil
    @lang2_pick = nil
    @lang3_pick = nil
    @lang4_pick = nil
    puts "What would you like your first language to be?"
    @lang1_pick = set_language
    if @language_count > 3
      puts "Now choose your second language:"
      @lang2_pick = set_language
      puts "And your third language:"
      @lang3_pick = set_language
      puts "And finally, your fourth language:"
      @lang4_pick = set_language
    elsif @language_count > 2
      puts "Now choose your second language:"
      @lang2_pick = set_language
      puts "And your third language:"
      @lang3_pick = set_language
    elsif @language_count > 1
      puts "Now choose your second language:"
      @lang2_pick = set_language
    end
    puts @lang1_pick
    puts "-------------------"
    puts "You'll be translating '#{phrase}' into:"
    # list languages picked for translation
    [@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick].each do |lang|
      puts lang.capitalize if lang != nil
    end
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
  def call
    greet if @greeted == false
    set_phrase if @phrase == nil
    puts "How many languages would you like for your translation?"
    pick_a_number
    puts "Great! Let's choose your language(s)."
    puts "If you'd like to see a list of languages available for translation,
please enter 'list languages'. Otherwise, press 'Enter'."
    input = gets.strip
    list_languages if input == "list languages"
    puts "-------------------"
    pick_languages
    @stone.translate(@phrase)
    menu
  end

  # continued menu options are presented once first translation is complete
  def menu
    puts "-------------------"
    puts "To pick new languages, enter 'new languages',
to translate a new phrase, enter 'new phrase',
to get details/examples for a specific word, enter 'details',
or to exit, please enter 'exit'."
    puts "-------------------"
    input = gets.strip
    case input
    when "new languages"
      # run a new translation with current phrase
      new_translation
    when "new phrase"
      # get a new phrase and translate into current languages
      set_phrase
      @stone.translate(@phrase)
      menu
    when "details"
      # get word and language, scrape wordreference for details
      puts "Which language would you like details for?"
      deet_lang = Language.find_or_create(gets.strip)
      puts "Great. Which word of '#{@phrase}' would you like further details on?"
      deet_word = gets.strip
      details = DetailScraper.new(deet_lang, deet_word)
      details.scrape
      menu
    when "exit"
      # allow user to exit program
      return
    end
  end

end
