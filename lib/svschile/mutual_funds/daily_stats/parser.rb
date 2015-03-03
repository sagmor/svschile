require 'spreadsheet'

module SVSChile
  module MutualFunds
    module DailyStats
      class Parser
        def initialize(file)
          @file = file
          @workbook = Spreadsheet.open(file.path)
        end

        def inspect
          "#<#{self.class.name}:#{@file.path}>"
        end

        def funds
          @workbook.worksheet(0).map do |row|
            begin
              FundStats.new(*row.to_a)
            rescue FundStats::InvalidStatsError
              nil
            rescue => error
              raise error
            end
          end.compact
        end
      end
    end
  end
end
