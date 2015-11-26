json.array!(@comp_competitions) do |comp_competition|
  json.extract! comp_competition, :id, :name, :type
  json.url comp_competition_url(comp_competition, format: :json)
end
