# frozen_string_literal: true

class ResultFileUtil
  class << self
    def summary_file_path(client_name, suffix)
      outputdir = prepare_outputdir(suffix)
      outputdir + format(Settings.output_filename_format, user_name: Settings.user_name, client_name: client_name, suffix: suffix)
    end

    def prepare_outputdir(suffix)
      outputdir = "#{ROOT_DIR}/results/toggl_#{Settings.user_name}_#{suffix}/"
      FileUtils.mkdir_p(outputdir)
      outputdir
    end
  end
end
