require 'bundler'
Bundler.require

require 'require_all'
Dotenv.load
require 'open-uri'
require 'google/cloud/translate'

# load all ruby files in the directory "lib" and its subdirectories
require_all 'lib'
