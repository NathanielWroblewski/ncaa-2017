require 'mechanize'
require 'csv'

teams = {}

CSV.foreach('./datasets/efficiency.csv', headers: true, header_converters: :symbol) do |row|
  next unless row[:year] == '2017'
  id = row[:team]

  teams[id] = { offense: row[:offense], defense: row[:defense] }
end

ids_to_name = {}

CSV.foreach('./datasets/ids.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:team_id]

  ids_to_name[id] = row[:team_name]
end

matches = teams.keys.combination(2).to_a

matchups = matches.map do |pair|
  home, away = pair
  home_offense = teams[home][:offense]
  home_defense = teams[home][:defense]
  away_offense = teams[away][:offense]
  away_defense = teams[away][:defense]

  [home_offense, home_defense, away_offense, away_defense, 1, ids_to_name[home], ids_to_name[away]]
end

CSV.open('./datasets/bracket.csv', 'w') do |csv|
  csv << %w(home_offense home_defense away_offense away_defense neutral_location home_team away_team)

  matchups.each do |matchup|
    csv << matchup
  end
end
