json.array!(@musics) do |music|
  json.extract! music, :id, :name
  json.url music_url(music, format: :json)
end
