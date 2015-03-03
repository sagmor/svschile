require "svschile/mutual_funds/daily_stats/downloader"
require "svschile/mutual_funds/daily_stats/parser"
require "svschile/mutual_funds/daily_stats/fund_stats"

module SVSChile
  module MutualFunds
    module DailyStats
      def self.fetch(date)
        downloader = Downloader.new(date)
        downloader.download
        parser = downloader.parser

        parser.funds
      end
    end
  end
end
