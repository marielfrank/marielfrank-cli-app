class Stone
  @@all = []
  attr_accessor :lang1, :lang2, :lang3, :lang4

  # create a new language stone
  def initialize(lang1, lang2 = nil, lang3 = nil, lang4 = nil)
    @lang1 = lang1
    @lang2 = lang1
    @lang3 = lang1
    @lang4 = lang1
  end

end
