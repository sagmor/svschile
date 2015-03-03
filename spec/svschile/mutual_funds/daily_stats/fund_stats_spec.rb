require 'spec_helper'

describe SVSChile::MutualFunds::DailyStats::FundStats do

  it "Accepts properly formatted parameters" do
    [
      # Fragment of a real file
      ["CAPITALES", "8038-1", 5.0, nil, "PLAN3", "PESOS", 127.916504, 61.0, 1175.4482],
      ["CAPITALES", "8038-1", 5.0, nil, "PLAN4", "PESOS", 386.284236, 148.0, 1270.0378],
      ["BANCHILE-ACCIONES", "8043-8", 5.0, nil, "A", "PESOS", 23835.820959, 3332.0, 3321.9873],
      ["BANCHILE-ACCIONES", "8043-8", 5.0, nil, "B", "PESOS", 4342.096962, 825.0, 6548.9211],
      ["BANCHILE-ACCIONES", "8043-8", 5.0, nil, "C", "PESOS", 981.338272, 68.0, 832.5468],
      ["BANCHILE-ACCIONES", "8043-8", 5.0, nil, "S", "PESOS", 0.0, 0.0, 1000.0],
      ["BICE ACCIONES", "8046-2", 5.0, nil, "A", "PESOS", 1712.607119, 304.0, 1114.5232],
      ["BICE ACCIONES", "8046-2", 5.0, nil, "B", "PESOS", 28.120071, 35.0, 1242.5327],
      ["BICE ACCIONES", "8046-2", 5.0, nil, "C", "PESOS", 8820.940484, 1098.0, 1605.4733],
      ["BICE ACCIONES", "8046-2", 5.0, nil, "F", "PESOS", 453.091855, 101.0, 1335.3597],
    ].each do |params|
      stats = described_class.new(*params)
      expect(stats.value).to be_equal(params.last)
    end
  end

  it "rejects inproperly formatted parameters" do
    [
      # Fragment of a real file
      ["SUPERINTENDENCIA DE VALORES Y SEGUROS"],
      ["EstadÃ­stica de los Fondos Mutuos "],
      [" "],
      ["Patrimonio, Participes y Valor de la Cuota por Fecha Diaria"],
      ["Administradora : TODAS "],
      ["Tipo de fondo : TODOS "],
      ["Moneda de la consulta : TODAS "],
      ["Fecha : 1 DE DICIEMBRE DE 2014 "],
      [nil],
      ["  ", "RUN", "Tipo de fondo (2)", "Administradora", "Serie", "Patrimonio (1)", "Numero de participes", "Valor cuota"],
      [],
      [" (1)  Cifras en millones de pesos o de la moneda que corresponda "],
      ["(2) Tipo de fondo: "],
      ["    1: FM DE INV.EN INST.DE DEUDA DE C/P CON DURACION <= 90 DIAS, "],
      ["   2: FM DE INV.EN INST.DE DEUDA DE C/P CON DURACION <= 365 DIAS, "],
      ["   3: FM DE INV.EN INST.DE DEUDA DE MEDIANO Y LARGO PLAZO,  "],
      ["   4: FM MIXTO,  "],
      ["   5: FM DE INVERSION EN INSTRUMENTOS DE CAPITALIZACION,  "],
      ["   6: FM DE LIBRE INVERSION,  "],
      ["   7: FM ESTRUCTURADO,   "],
      ["   8: FM DIRIGIDO A INVERSIONISTAS CALIFICADOS, "],
    ].each do |params|
      expect{ described_class.new(*params) }.to raise_error(described_class::InvalidStatsError)
    end
  end

end
