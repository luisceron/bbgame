json.array!(@comp_fixtures) do |comp_fixture|
  json.extract! comp_fixture, :id
  json.url comp_fixture_url(comp_fixture, format: :json)
end
