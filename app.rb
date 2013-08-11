require 'sinatra'
require 'sinatra/reloader'
require 'json'

configure :test,:development do
  set :public_folder, Proc.new { File.join(root, 'front_end/dist') }
end

get '/api/V1/index', :provides => :json do
  content_type :json
  json_status 404, "Not fosund"
end



# A utility method for setting get_or_post routes
def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end

# Catch all routes being passed to the angular app
get_or_post '/*' do
  send_file File.join(settings.public_folder, 'index.html')
end

helpers do
  def json_status(code, message)
    status(code)
    { :status => code, :message => message }.to_json
  end
end
