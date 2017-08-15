module Translator
  def initialize(language, phrase)
    @language = language
    @phrase = phrase
    @language.phrases << @phrase
  end
  #initialize accepts a stone
  #translate accepts argument of phrase, initializes new webscrape object for each non-nil language
  #details checks most recent translator object and gets detailed view of specific lang's translation with further translations, transliterations

  # Your Google Cloud Platform project ID
  project_id = "rosetta-search"

  # Instantiates a client
  TRANSLATE = Google::Cloud::Translate.new(
    project: project_id,
    key: ENV["rosetta_key"]
  )

# The text to translate
text = "Hello, world!"
# The target language
target = "ru"

# Translates some text into Russian
# translation = translate.translate text, to: target

# puts "Text: #{text}"
# puts "Translation: #{translation}"
end
