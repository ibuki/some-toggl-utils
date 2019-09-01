# frozen_string_literal: true

class Summary
  attr_reader :beginning_date, :end_date
  def initialize(beginning_date, end_date)
    @beginning_date = beginning_date
    @end_date = end_date
  end

  def client_times
    summary[:data]
      .each_with_object(Hash.new(0)) { |project, obj| obj[project[:title][:client].tr(' ', '').downcase] += project[:time] }
      .sort_by(&:last)
      .reverse
  end

  def client_times_as_text
    puts "先週(#{beginning_date_str}〜#{end_date_str})の活動時間"

    client_times.each do |client_name, time|
      print_entry(client_name, time)
    end
    print_entry('total', summary[:total_grand])
  end

  def summary
    JSON.parse(conn.get(endpoint, default_params).body).with_indifferent_access
  end

  def minutize(msec)
    minute = msec / 1000 / 60
    format('%3d時間 %2d分', minute / 60, minute % 60)
  end

  def print_entry(name, msec)
    puts "#{name.ljust(15)}: #{minutize(msec)}"
  end

  def endpoint
    '/reports/api/v2/summary'
  end

  def conn
    @conn ||= Faraday.new('https://toggl.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(Settings.toggl_api_token, 'api_token')
    end
  end

  def default_params
    {
      workspace_id: Settings.workspace_id,
      user_agent: 'chrome',
      since: beginning_date_str,
      until: end_date_str,
    }
  end

  def beginning_date_str
    beginning_date.strftime('%Y-%m-%d')
  end

  def end_date_str
    end_date.strftime('%Y-%m-%d')
  end
end
