# frozen_string_literal: true

require_relative './config/init'

class Status < Thor
  desc 'list_clients', 'get your first workspace_id and its clients list'
  def list_clients
    puts ClientsFetcher.new.as_yml
  end

  desc 'durations', 'get each of your client duration'
  def durations
    beginning_date = 1.month.ago.beginning_of_month
    end_date = 1.month.ago.end_of_month
    puts Summary.new(beginning_date, end_date).decorate.client_times_as_text
  end
end
