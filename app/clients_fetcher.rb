# frozen_string_literal: true

require 'pry'

class ClientsFetcher
  def as_yml
    <<~YML
      workspace_id: #{first_wid}
      clients:
      #{clients_yml}
    YML
  end

  private

  def clients_yml
    client_names_and_ids.map { |name, id| client_yml_row(name, id) }.join("\n")
  end

  def client_yml_row(name, id)
    "  #{name}: #{id}"
  end

  def client_names_and_ids
    @client_names_and_ids ||= api.clients.select { |client| client['wid'] == first_wid }.pluck('name', 'id')
  end

  def api
    @api ||= TogglV8::API.new(Settings.toggl_api_token)
  end

  def first_wid
    @first_wid ||= api.clients.first['wid']
  end
end
