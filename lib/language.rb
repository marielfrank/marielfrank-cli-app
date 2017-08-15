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
    new_lang.code = LANGUAGES[new_lang.symbolize]
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
  chinese_simplified: "zh",
  chinese_traditional: "zh-tw",
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
  punjabi: "ma",
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
