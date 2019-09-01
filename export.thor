# frozen_string_literal: true

require_relative './config/init'

class Export < Thor
  desc 'summaries', 'get  your summary pdf file for each company'
  def summaries
    Settings.clients.each do |client_name, client_id|
      month = 1.month.ago
      filename = ResultFileUtil.summary_file_path(client_name, month.strftime('%Y%m'))
      puts "Downloading '#{filename}'... "
      MonthSummaryFetcher.new(client_id, month).as_pdf(filename)
      sleep(1)
    end
  end
end
