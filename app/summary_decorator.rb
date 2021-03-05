# frozen_string_literal: true

class SummaryDecorator
  attr_reader :summary
  delegate_missing_to :summary

  def initialize(summary)
    @summary = summary
  end

  def client_times_as_text
    puts "#{beginning_date_str}〜#{end_date_str}の活動時間"

    client_times.each do |client_name, msec|
      print_entry(client_name, msec)
    end
    print_entry('total', total_grand)
  end

  def client_times_with_messages
    client_times.each do |client_name, msec|
      puts message(client_name, msec)
    end
  end

  def message(client_name, msec)
    <<-MESSAGE.gsub(/^\s+/, '')
      #{client_name}
      お疲れ様です！月半ばですので稼働時間の報告を送ります。
      #{beginning_date_str}〜#{end_date_str}の稼働時間は#{minutize(msec)}です。
      引き続きよろしくお願いします。
    MESSAGE
  end

  def minutize(msec)
    minute = msec / 1000 / 60
    format('%<hour>d時間%<minute>d分', hour: minute / 60, minute: minute % 60)
  end

  def hourize(msec)
    minute = msec / 1000 / 60
    format('%.2fh', minute.fdiv(60))
  end

  def print_entry(name, msec)
    puts "#{name.ljust(15)}: #{minutize(msec)} (#{hourize(msec)})"
  end
end
