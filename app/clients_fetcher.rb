# frozen_string_literal: true

require 'pry'

class ClientsFetcher
  def as_yml
    {
      user_id: me['id'],
      workspaces: workspace_ids.map do |workspace_id|
        {
          workspace_id: workspace_id,
          clients: clients_filter_by_workspace_id(workspace_id).pluck('name', 'id').to_h
        }
      end
    }.deep_stringify_keys.to_yaml
  end

  private

  def workspace_ids
    me['workspaces'].pluck('id')
  end

  def clients_filter_by_workspace_id(wid)
    clients.select { |client| client['wid'] == wid }
  end

  def clients
    @clients ||= api.clients
  end

  def me
    @me ||= api.me
  end

  def api
    @api ||= TogglV8::API.new(Settings.toggl_api_token)
  end
end
