require 'open-uri'
require 'tempfile'

module SVSChile
  module MutualFunds
    module DailyStats
      class Downloader
        ALL = 0
        URL = "http://www.svs.cl/sitio/estadisticas/fm.fm_bpr_dia.php?admins=0&tipofondo=0&moneda=0&dia_select=%d&mes_peri=%d&anio_peri=%d&out=excel"
        DEFAULTS = {
          admins: ALL,
          tipofondo: ALL,
          moneda: ALL,
          dia_select: nil,
          mes_peri: nil,
          anio_peri: nil,
          out: "excel"
        }

        def initialize(date)
          raise "Date must be in the past (#{date})" if date >= Time.now.to_date

          @date = date
        end

        def remote_url
          URL % [@date.day, @date.month, @date.year]
        end

        def local_file
          @local_file ||= Tempfile.new('excel')
        end

        def download
          # the following "open" is provided by open-uri
          open(self.remote_url, "rb") do |read_file|
            self.local_file.write(read_file.read)
          end
        end

        def copy(to)
          FileUtils.cp self.local_file.path, to
        end

        def parser
          Parser.new(self.local_file)
        end
      end
    end
  end
end
