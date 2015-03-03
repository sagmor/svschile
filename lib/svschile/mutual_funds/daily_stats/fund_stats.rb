module SVSChile
  module MutualFunds
    module DailyStats
      # A very simple class to represent a mutual fund's day stats
      class FundStats < Struct.new(:name,:run,:type_id,:administrator,:serie,:currency,:gross_value,:members,:value)
        TYPES = [
          nil,
          "FM DE INV.EN INST.DE DEUDA DE C/P CON DURACION <= 90 DIAS",
          "FM DE INV.EN INST.DE DEUDA DE C/P CON DURACION <= 365 DIAS",
          "FM DE INV.EN INST.DE DEUDA DE MEDIANO Y LARGO PLAZO",
          "FM MIXTO",
          "FM DE INVERSION EN INSTRUMENTOS DE CAPITALIZACION",
          "FM DE LIBRE INVERSION",
          "FM ESTRUCTURADO",
          "FM DIRIGIDO A INVERSIONISTAS CALIFICADOS"
        ]

        # Add some simple validations
        def initialize(*args)
          super

          # Cast integer values
          self.type_id = self.type_id.to_int
          self.members = self.members.to_int

          # Some quick validations to filter wrong stats
          raise InvalidStatsError, "Invalid value" if self.value.nil?
        end

        def type
          TYPES[self.type_id]
        end

        class InvalidStatsError < ArgumentError; end
      end
    end
  end
end
