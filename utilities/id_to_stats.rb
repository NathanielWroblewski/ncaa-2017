require 'csv'

names = {}

CSV.foreach('./datasets/ids.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:team_id]
  name = row[:team_name]

  names[id] = name
end

teams = {}

CSV.foreach('./datasets/efficiency.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:team]
  offense = row[:offense]
  defense = row[:defense]
  year = row[:year]

  teams[year] ||= {}
  teams[year][id] = { offense: offense, defense: defense, name: names[id] }
end

results = []

CSV.foreach('./datasets/spreads.csv', headers: true, header_converters: :symbol) do |row|
  spread = row[:moneyline]
  winloss = row[:winloss]
  home_id = row[:home]
  away_id = row[:away]
  year = row[:season]

  teams[year] ||= {}
  home_team = teams[year][home_id] || {}
  away_team = teams[year][away_id] || {}

  results << [
    year,
    spread,
    home_id,
    home_team[:name],
    home_team[:offense],
    home_team[:defense],
    away_id,
    away_team[:name],
    away_team[:offense],
    away_team[:defense],
    winloss
  ]
end

CSV.open('./datasets/spreads2.csv', 'w') do |csv|
  csv << %w(year spread home_id home_team home_offense home_defense away_id away_team away_offense away_defense winloss)

  results.each do |row|
    csv << row
  end
end
