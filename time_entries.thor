# frozen_string_literal: true

require_relative './config/init'

class TimeEntriesThor < Thor
  namespace :time_entries

  desc 'create_entry', 'put a time entry for 1 hour'
  def create_entry
    puts 'create_entry'
    TimeEntries.new.create_entry
  end
end
