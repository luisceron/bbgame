json.array!(@comp_rounds) do |comp_round|
  json.extract! comp_round, :id
  json.url comp_round_url(comp_round, format: :json)
end
