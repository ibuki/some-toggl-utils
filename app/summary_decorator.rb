# frozen_string_literal: true

class SummaryDecorator
  attr_reader :summary
  delegate_missing_to :summary

  def initialize(summary)
    @summary = summary
  end

  def client_times_as_text
    puts "先週(#{beginning_date_str}〜#{end_date_str})の活動時間"

    client_times.each do |client_name, time|
      print_entry(client_name, time)
    end
    print_entry('total', total_grand)
  end

  def minutize(msec)
    minute = msec / 1000 / 60
    format('%3d時間 %2d分', minute / 60, minute % 60)
  end

  def print_entry(name, msec)
    puts "#{name.ljust(15)}: #{minutize(msec)}"
  end
end
