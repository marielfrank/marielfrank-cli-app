require 'bundler'
Bundler.require

require 'require_all'

# load all ruby files in the directory "lib" and its subdirectories
require_all 'lib'