# frozen_string_literal: true

require 'togglv8'
require 'yaml'

Settings = YAML.load_file('settings.yml').freeze
api = TogglV8::API.new(Settings['toggl_api_token'])

workspace_id = api.clients.first['wid']
puts "workspace_id: #{workspace_id}"
puts
api.clients.select { |client| client['wid'] == workspace_id }.each do |client|
  puts "#{client['name'].tr(' ', '').downcase}: #{client['id']}"
end
