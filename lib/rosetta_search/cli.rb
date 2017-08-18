class RosettaSearch::CLI
  attr_accessor :language_count, :stone, :lang1_pick, :lang2_pick,
    :lang3_pick, :lang4_pick, :phrase, :greeted, :valid_languages

  def initialize(greeted = false)
    @greeted = greeted
  end

  # greet user
  def greet
    # welcome message
    puts "-------------------------------------------"
    puts "|" + "      Welcome to Rosetta Search!         ".green + "|"
    puts "-------------------------------------------"
    puts "You can translate from English into several languages at once :)".green
    # change @greeted to true
    @greeted = true
  end

  # set new phrase for translation
  def set_phrase
    puts "Please enter the phrase that you would like to translate:".green
    @phrase = gets.strip
    puts "Excellent.".green
  end

  # pick how many languages for translation
  def pick_a_number
    puts "Please choose a number between 1 and 4.".green
    # turn string to integer
    @language_count = gets.strip.to_i
    # make sure number is within range
    pick_a_number if @language_count < 1 || @language_count > 4
  end

  # create list of languages available for translation through Google Cloud Translation API
  def valid_languages
    RosettaSearch::LANGUAGES.map do |lang, code|
      lang.to_s.capitalize.gsub("_", " ")
    end
  end

  # list languages
  def list_languages
    puts self.valid_languages.join(", ").cyan
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
      puts "Oops! Looks like we don't have that language.".yellow
      # option to see full language list again
      puts "Would you like to see the full list of languages again? (y/n)".green
      gets.strip.downcase == "y" ? list_languages : puts("Good memory!".green)
      # try setting the language again
      puts "Please enter a language from our list.".green
      language_pick = set_language
    end
    # return the language name that we picked
    language_pick
  end

  # reset languages and choose new ones
  def pick_languages
    puts "How many languages would you like for your translation?".green
    pick_a_number
    puts "Great! Let's choose your language(s).".green
    puts "If you'd like to see a list of languages available for translation,
please enter 'list languages'. Otherwise, press 'Enter'.".green
    input = gets.strip
    list_languages if input == "list languages"
    puts "-------------------"
    @lang1_pick = nil
    @lang2_pick = nil
    @lang3_pick = nil
    @lang4_pick = nil
    puts "What would you like your first language to be?".green
    @lang1_pick = set_language
    if @language_count > 3
      pick_2_and_3
      puts "And finally, your fourth language:".green
      @lang4_pick = set_language
    elsif @language_count > 2
      pick_2_and_3
    elsif @language_count > 1
      puts "Now choose your second language:".green
      @lang2_pick = set_language
    end
    puts "-------------------"
    puts "You'll be translating '#{@phrase}' into:".green
    # list languages picked for translation
    [@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick].each do |lang|
      puts lang.capitalize.light_white if lang != nil
    end
    # create new language stone from picked languages
    @stone = RosettaSearch::Stone.new(@lang1_pick, @lang2_pick, @lang3_pick, @lang4_pick)
    translate
  end

  # for picks of more than two languages
  def pick_2_and_3
    puts "Now choose your second language:".green
    @lang2_pick = set_language
    puts "And your third language:".green
    @lang3_pick = set_language
  end

  # run translation
  def translate
    @stone.translate(@phrase)
  end

  def get_details
    puts "Which language would you like details for?".green
    deet_lang = RosettaSearch::Language.find_or_create(gets.strip)
    puts "Great. Which word of '#{@phrase}' would you like further details on?".green
    deet_word = gets.strip
    details = RosettaSearch::DetailScraper.new(deet_lang, deet_word)
    details.scrape
  end

  # primary CLI method
  def call
    greet if @greeted == false
    set_phrase if @phrase == nil
    pick_languages
    menu
    goodbye
  end

  # continued menu options are presented once first translation is complete
  def menu
    input = nil
    while input != "exit"
      puts "-------------------"
      puts "To pick new languages, enter 'new languages',
to translate a new phrase, enter 'new phrase',
to get details/examples for a specific word, enter 'details',
or to exit the program, enter 'exit'.".red
      puts "-------------------"
      input = gets.strip
      case input
      when "new languages"
        # run a new translation with current phrase
        pick_languages
      when "new phrase"
        # get a new phrase and translate into current languages
        set_phrase
        translate
      when "details"
        # get word and language, scrape wordreference for details
        get_details
      else
        puts "Sorry, that isn't a command I recognize.".yellow unless input == "exit"
      end
    end
  end

  def goodbye
    puts "Thank you for using Rosetta Search! Hope to see you again soon.".green
  end

end
