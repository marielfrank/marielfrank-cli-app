class Language
  @@all = []
  attr_accessor :name, :code, :urls, :phrases

  def initialize
    @phrases = []
    @urls = []
    @@all << self
  end

  # list all languages that have been created
  def self.all
    @@all
  end

  def self.find_or_create(lang_name)
    # search @@all for self
    # if exist, return self
    # otherwise, self.new, search LANGUAGES hash and set code
    # return self
  end
end

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

# hash of languages & codes (https://cloud.google.com/translate/docs/languages)
