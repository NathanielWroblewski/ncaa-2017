require 'csv'

lookup = {}

CSV.foreach('./datasets/ids.csv', headers: true, header_converters: :symbol) do |row|
  id = row[:team_id]
  name = row[:team_name]

  lookup[name] = id
end

results = []

CSV.foreach('./datasets/spreads.csv', headers: true, header_converters: :symbol) do |row|
  results << [
    row[:moneyline],
    row[:winloss],
    row[:home],
    row[:away],
    row[:season]
  ]
end

def format(team_name)
  team_name.gsub(/\s+\(N\)/, '')
    .gsub('(N)', '')
    .gsub('North ', 'N ')
    .gsub('East ', 'E ')
    .gsub('South ', 'S ')
    .gsub('West ', 'W ')
    .gsub('Northern ', 'N ')
    .gsub('Eastern ', 'E ')
    .gsub('Western ', 'W ')
    .gsub('Mt.', 'Mt')
    .gsub('St.', 'St')
    .gsub('State', 'St')
    .gsub('Texas Rio Grande Valley', 'UTRGV')
    .gsub('Kent St', 'Kent')
    .gsub('NC-Wilmington', 'UNC Wilmington')
    .gsub('Cal. State - Bakersfield', 'CS Bakersfield')
    .gsub('UMKC', 'Missouri KC')
    .gsub('Indiana - Purdue', 'Purdue')
    .gsub('Albany', 'Albany NY')
    .gsub('Stephen F. Austin', 'SF Austin')
    .gsub('MD Baltimore Cty', 'UMBC')
    .gsub('Saint Louis', 'St Louis')
    .gsub('Green Bay', 'WI Green Bay')
    .gsub('W Virginia', 'West Virginia')
    .gsub('New Jersey Tech', 'NJIT')
    .gsub('Boston U', 'Boston Univ')
    .gsub('American', 'American Univ')
    .gsub('S Alabama', 'South Alabama')
    .gsub('Massachusetts Lowell', 'MA Lowell')
    .gsub('VCU', 'VA Commonwealth')
    .gsub('Coastal Carolina', 'Coastal Car')
    .gsub('LIU Brooklyn', 'Brooklyn')
    .gsub('Florida Atlantic', 'FL Atlantic')
    .gsub('N Carolina', 'North Carolina')
    .gsub('Central Florida', 'UCF')
    .gsub('Texas-El Paso', 'UTEP')
    .gsub('Louisiana-Lafayette', 'ULL')
    .gsub('E Carolina', 'East Carolina')
    .gsub('S Florida', 'South Florida')
    .gsub('Middle Tennessee St', 'MTSU')
    .gsub('Charleston S', 'Charleston So')
    .gsub('Charleston', 'Col Charleston')
    .gsub('The Citadel', 'Citadel')
    .gsub('W Virginia', 'West Virginia')
    .gsub('N Arizona', 'Northern Arizona')
    .gsub('N Iowa', 'Northern Iowa')
    .gsub('Brigham Young', 'BYU')
    .gsub('Miami (OH)', 'Miami OH')
    .gsub('Elon University', 'Elon')
    .gsub('E Tennessee St', 'ETSU')
    .gsub('Miami-Florida', 'Miami FL')
    .gsub('Southern Illinois', 'S Illinois')
    .gsub('N.C. St', 'NC State')
    .gsub('George Washington', 'G Washington')
    .gsub('Louisiana St', 'LSU')
    .gsub('Louisiana-Monroe', 'ULM')
    .gsub('Tenn-Martin', 'TN Martin')
    .gsub('N Texas', 'North Texas')
    .gsub('Texas-Arlington', 'UT Arlington')
    .gsub('Texas Christian', 'TCU')
    .gsub('Florida International', 'Florida Intl')
    .gsub('Texas A&M CC', 'TAM C. Christi')
    .gsub('Loyola Marymount', 'Loy Marymount')
    .gsub('Loyola Chicago', 'Loyola-Chicago')
    .gsub('Georgia Southern', 'Ga Southern')
    .gsub('Southern Methodist', 'SMU')
    .gsub('Arkansas-Little Rock', 'Ark Little Rock')
    .gsub("St Joseph's", "St Joseph's PA")
    .gsub('CSU Northridge', 'CS Northridge')
    .gsub('Cal St Fullerton', 'CS Fullerton')
    .gsub('NC-Greensboro', 'UNC Greensboro')
    .gsub('Central Michigan', 'C Michigan')
    .gsub('WVirginia', 'West Virginia')
    .gsub('MD Baltimore City', 'UMBC')
    .gsub('Florida Gulf Coast', 'FL Gulf Coast')
    .gsub('Kennesaw St', 'Kennesaw')
    .gsub('N Florida', 'North Florida')
    .gsub('S Carolina Upstate', 'SC Upstate')
    .gsub('N Dakota', 'North Dakota')
    .gsub('S Dakota', 'South Dakota')
    .gsub('Sacramento St', 'CS Sacramento')
    .gsub('Col Charleston Soouthern', 'Charleston So')
    .gsub('Gardner-Webb', 'Gardner Webb')
    .gsub('NC-Asheville', 'UNC Asheville')
    .gsub('N.C. Asheville', 'UNC Asheville')
    .gsub('UC Santa Barbara', 'Santa Barbara')
    .gsub('Texas-San Antonio', 'UT San Antonio')
    .gsub('W Kentucky', 'WKU')
    .gsub('Detroit Mercy', 'Detroit')
    .gsub('Illinois-Chicago', 'IL Chicago')
    .gsub('Wis.-Milwaukee', 'WI Milwaukee')
    .gsub('Monmouth-NJ', 'Monmouth NJ')
    .gsub('Maryland - E. Shore', 'MD E Shore')
    .gsub('No.Carolina A&T', 'NC A&T')
    .gsub('North Carolina Central', 'NC Central')
    .gsub('Central Conn. St', 'Central Conn')
    .gsub('Fairleigh Dickinson', 'F Dickinson')
    .gsub("Mount St Mary's", "Mt St Mary's")
    .gsub('St Francis (PA)', 'St Francis PA')
    .gsub('St Francis-NY', 'St Francis NY')
    .gsub('St Francis (NY)', 'St Francis NY')
    .gsub('SIU - Edwardsville', 'Edwardsville')
    .gsub('Southern California', 'USC')
    .gsub('American Univ U.', 'American Univ')
    .gsub('Loyola-Maryland', 'Loyola MD')
    .gsub('S Carolina', 'South Carolina')
    .gsub('Abilene Christian', 'Abilene Chr')
    .gsub('Houston Baptist', 'Houston Bap')
    .gsub('Central Arkansas', 'Cent Arkansas')
    .gsub('Northwestern St', 'Northwestern LA')
    .gsub('Southeastern Louisiana', 'SE Louisiana')
    .gsub('Arkansas-Pine Bluff', 'Ark-Pine Bluff')
    .gsub('Grambling St', 'Grambling')
    .gsub('Mississippi Valley St', 'MS Valley St')
    .gsub('Prairie View A&M', 'Prairie View')
    .gsub('Texas Southern', 'TX Southern')
    .gsub('IUPU - Ft. Wayne', 'IPFW')
    .gsub('Nebraska Omaha', 'NE Omaha')
    .gsub('Little Rock', 'Ark Little Rock')
    .gsub('Ark Ark Little Rock', 'Ark Little Rock')
    .gsub('Cal. St - Bakersfield', 'CS Bakersfield')
    .gsub('Texas-Pan American Univ', 'UTRGV')
    .gsub('Michigan Tech', 'UTRGV')
    .gsub('W Alabama', 'UTRGV')
    .gsub('San Francisco St', 'San Francisco')
    .gsub('Birmingham Southern', 'Birmingham So')
    .gsub('Winston-Salem', 'W Salem St')
    .gsub('South Carolina St', 'S Carolina St')
    .gsub('North Dakota St', 'North Dakota')
    .gsub('South Dakota St', 'South Dakota')
    .gsub('Ark-Pine Bluff', 'Ark Pine Bluff')
    .gsub('Pennsylvania', 'Penn')
end

results = results.map do |row|
  home = format(row[2])
  away = format(row[3])

  home = lookup[home] || home
  away = lookup[away] || away

  year = row[4].split('-').last

  [row[0], row[1], home, away, year]
end

CSV.open('./datasets/spreads_ids.csv', 'w') do |csv|
  csv << %w(moneyline winloss home away season)

  results.each do |row|
    csv << row
  end
end


