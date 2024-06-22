require 'bundler/setup'
Bundler.require(:default)

require 'sinatra'
require 'json'
require 'sqlite3'
require_relative 'my_user_model'

enable :sessions

set :views, './views'

before do
  @user_model = User.new
end

get '/users' do
  users = @user_model.all
  users.each { |user| user.delete('password') }
  users.to_json
end

post '/users' do
  user_info = [params[:firstname], params[:lastname], params[:age].to_i, params[:password], params[:email]]
  user_id = @user_model.create(user_info)
  user = @user_model.find(user_id)
  user.reject! { |k| k == 'password' }
  user.to_json
end

post '/sign_in' do
  user = @user_model.find_by_email(params[:email])
  if user && user['password'] == params[:password]
    session[:user_id] = user['id']
    user.reject! { |k| k == 'password' }
    user.to_json
  else
    status 401
    { error: 'Invalid credentials' }.to_json
  end
end

put '/users' do
  if session[:user_id]
    user_id = session[:user_id]
    @user_model.update(user_id, 'password', params[:new_password])
    user = @user_model.find(user_id)
    user.reject! { |k| k == 'password' }
    user.to_json
  else
    status 401
    { error: 'Not logged in' }.to_json
  end
end

delete '/sign_out' do
  session.clear
  status 204
end

delete '/users' do
  if session[:user_id]
    user_id = session[:user_id]
    @user_model.destroy(user_id)
    session.clear
    status 204
  else
    status 401
    { error: 'Not logged in' }.to_json
  end
end

get '/' do
  erb :index
end