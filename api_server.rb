require 'sinatra'
require 'JSON'
require 'redis'
$redis = Redis.new(host: "127.0.0.1", port: 6379, db: 1)

# list all
get '/offers' do
  if $redis.get('CMS:offers')
    $offers = $redis.get('CMS:offers')
  end
  return JSON.parse $offers.to_json
end

# view one
get '/offers/:id' do
  if $redis.get('CMS:offer:' + params[:id])
    $offer = $redis.get('CMS:offer:' + params[:id])
  end
  return JSON.parse $offer.to_json
end

# create
post '/widgets' do
  widget = Widget.new(params['widget'])
  widget.save
  status 201
end

# update
put '/widgets/:id' do
  widget = Widget.find(params[:id])
  return status 404 if widget.nil?
  widget.update(params[:widget])
  widget.save
  status 202
end

delete '/widgets/:id' do
  widget = Widget.find(params[:id])
  return status 404 if widget.nil?
  widget.delete
  status 202
end