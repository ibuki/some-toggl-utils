# frozen_string_literal: true

require_relative './config/init'

class Init < Thor
  desc 'fetch_clients', 'get your clients list and workspace_id'
  def fetch_clients
    puts ClientsFetcher.new.as_yml
  end
end
