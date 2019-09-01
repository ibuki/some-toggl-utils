# frozen_string_literal: true

require_relative './config/init'

class Status < Thor
  desc 'list_clients', 'get your first workspace_id and its clients list'
  def list_clients
    puts ClientsFetcher.new.as_yml
  end
end
