# SVSChile

Programmatically access public data from http://www.svs.cl/

## Usage

### Fetch mutual funds stats for a given day

```ruby
date = Date.new(2014,12,1)
stats = SVSChile::MutualFunds::DailyStats.fetch(date)
puts stats.first.inspect
#<struct SVSChile::MutualFunds::DailyStats::FundStats name="CAPITALISA-ACC.", run="8001-2", type_number=5.0, administrator=nil, serie="A", currency="PESOS", gross_value=2142.722354, members=1544.0, value=355.1233>
```

## Contributing

1. Fork it ( https://github.com/sagmor/svschile/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
