json.array!(@pred_predictions) do |pred_prediction|
  json.extract! pred_prediction, :id
  json.url pred_prediction_url(pred_prediction, format: :json)
end
