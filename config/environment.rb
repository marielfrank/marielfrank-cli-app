require 'bundler'
Bundler.require

require 'require_all'
require 'open-uri'

# load all ruby files in the directory "lib" and its subdirectories
require_all 'lib'
