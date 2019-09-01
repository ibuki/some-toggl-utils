# frozen_string_literal: true

require_relative './config/init'

class Init < Thor
  desc 'get_clients', 'get your clients list and workspace_id'
  def get_clients
    api = TogglV8::API.new(Settings.toggl_api_token)

    workspace_id = api.clients.first['wid']
    puts "workspace_id: #{workspace_id}"
    puts
    puts 'clients:'
    api.clients.select { |client| client['wid'] == workspace_id }.each do |client|
      puts "  #{client['name'].tr(' ', '').downcase}: #{client['id']}"
    end
  end
end
