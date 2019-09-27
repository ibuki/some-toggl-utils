# frozen_string_literal: true

require_relative './config/init'

class Status < Thor
  desc 'list_clients', 'get your first workspace_id and its clients list'
  def list_clients
    puts ClientsFetcher.new.as_yml
  end

  desc 'durations_in_last_month', 'get last month durations for each client'
  def durations_in_last_month
    beginning_date = 1.month.ago.beginning_of_month
    end_date = 1.month.ago.end_of_month
    Summary.new(beginning_date, end_date).decorate.client_times_as_text
  end

  desc 'durations_in_this_month', 'get this month durations for each client'
  def durations_in_this_month
    beginning_date = Date.current.beginning_of_month
    end_date = Date.yesterday
    Summary.new(beginning_date, end_date).decorate.client_times_as_text
  end

  desc 'messages_about_this_month', 'get this month messages for each client'
  def messages_about_this_month
    beginning_date = Date.current.beginning_of_month
    end_date = Date.yesterday
    Summary.new(beginning_date, end_date).decorate.client_times_with_messages
  end
end
