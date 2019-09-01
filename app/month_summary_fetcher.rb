# frozen_string_literal: true

class MonthSummaryFetcher
  attr_reader :client_id, :month

  def initialize(client_id, month)
    @client_id = client_id
    @month = month
  end

  def as_pdf(filename)
    File.binwrite(filename, conn.get(endpoint, params).body)
  end

  def params
    {
      workspace_id: Settings.workspace_id,
      user_agent: 'chrome',
      since: month.beginning_of_month.strftime('%Y-%m-%d'),
      until: month.end_of_month.strftime('%Y-%m-%d'),
      client_ids: [client_id],
    }
  end

  def endpoint
    '/reports/api/v2/summary.pdf'
  end

  def conn
    @conn ||= Faraday.new('https://toggl.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(Settings.toggl_api_token, 'api_token')
    end
  end
end
