# frozen_string_literal: true

require_relative './config/init'

class Export < Thor
  desc 'summaries', 'get  your summary pdf file for each company'
  def summaries
    user_name = Settings.user_name
    yearmonth = 1.month.ago.strftime('%Y%m')
    outputdir = "#{__dir__}/results/toggl_#{user_name}_#{yearmonth}/"
    FileUtils.mkdir_p(outputdir)

    default_params = {
      workspace_id: Settings.workspace_id,
      user_agent: 'chrome',
      since: 1.month.ago.beginning_of_month.strftime('%Y-%m-%d'),
      until: 1.month.ago.end_of_month.strftime('%Y-%m-%d'),
    }

    endpoint = '/reports/api/v2/summary.pdf'

    conn = Faraday.new('https://toggl.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(Settings.toggl_api_token, 'api_token')
    end

    # Get summary pdfs about each client

    Settings.clients.each do |client_name, client_id|
      filename = format(Settings.output_filename_format, user_name: user_name, client_name: client_name, yearmonth: yearmonth)
      params = default_params.merge(client_ids: [client_id])

      puts "Downloading '#{filename}'... "
      File.binwrite(outputdir + filename, conn.get(endpoint, params).body)

      sleep(1)
    end

    puts 'Done'
  end
end
