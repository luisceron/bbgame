json.array!(@team_teams) do |team_team|
  json.extract! team_team, :id, :name, :country
  json.url team_team_url(team_team, format: :json)
end
