module SVSChile
  module MutualFunds
    module DailyStats
      # A very simple class to represent a mutual fund's day stats
      class FundStats < Struct.new(:name,:run,:type_number,:administrator,:serie,:currency,:gross_value,:members,:value)
        # Add some simple validations
        def initialize(*args)
          super

          # Cast integer values
          self.type_number = self.type_number.to_int
          self.members = self.members.to_int

          # Some quick validations to filter wrong stats
          raise InvalidStatsError, "Invalid value" if self.value.nil?
        end

        class InvalidStatsError < ArgumentError; end
      end
    end
  end
end
