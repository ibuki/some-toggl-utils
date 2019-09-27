# frozen_string_literal: true

class TimeEntries
  def create_entry(description: 'new_entry_from_api', start: Time.current.iso8601, duration: 3600)
    params = {
      time_entry: {
        description: description,
        start: start,
        duration: duration,
        created_with: 'some-toggl-utils',
      },
    }
    post(params)
  end

  def post(params)
    conn.post(endpoint, params.to_json)
  end

  private

  def endpoint
    '/api/v8/time_entries'
  end

  def conn
    @conn ||= Faraday.new('https://toggl.com') do |faraday|
      faraday.headers['Content-Type'] = 'application/json'
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(Settings.toggl_api_token, 'api_token')
    end
  end
end
