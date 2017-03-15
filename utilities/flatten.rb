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

CSV.foreach('./datasets/games.csv', headers: true, header_converters: :symbol) do |row|
  year = row[:season]

  next unless year.to_i >= 2002

  winner_location = row[:wloc]
  neutral = 0

  if winner_location == 'H'
    home = row[:wteam]
    away = row[:lteam]
  elsif winner_location == 'A'
    home = row[:lteam]
    away = row[:wteam]
  else
    neutral = 1

    if rand(2).even?
      home = row[:wteam]
      away = row[:lteam]
    else
      home = row[:lteam]
      away = row[:wteam]
    end
  end

  home_team = teams[year][home]
  away_team = teams[year][away]

  next if !home_team || !away_team

  home_win = home == row[:wteam] ? 1 : 0
  home_offense = home_team[:offense]
  home_defense = home_team[:defense]
  away_offense = away_team[:offense]
  away_defense = away_team[:defense]

  results << [
    year,
    home,
    home_team[:name],
    home_team[:offense],
    home_team[:defense],
    away,
    away_team[:name],
    away_team[:offense],
    away_team[:defense],
    neutral,
    home_win
  ]
end

CSV.open('./datasets/games2.csv', 'w') do |csv|
  csv << %w(year home_id home_team home_offense home_defense away_id away_team away_offense away_defense neutral_site home_win)

  results.each do |row|
    csv << row
  end
end
