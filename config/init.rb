# frozen_string_literal: true

require 'togglv8'
require 'yaml'
require 'settingslogic'
require 'active_support'
require 'active_support/core_ext'

ROOT_DIR = "#{__dir__}/.."
Dir["#{ROOT_DIR}/app/**/*.rb"].each { |f| require(f) }
