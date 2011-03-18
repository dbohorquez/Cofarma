require 'rubygems'
require 'sinatra'
require 'haml'

configure do
  set :views, "#{File.dirname(__FILE__)}/"
  set :public, "#{File.dirname(__FILE__)}/"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  def partial(template, options = {})
    options.merge!(:layout => false)
    haml("partials/#{template}".to_sym, options)
  end
end

get '/:folder/:page_name' do
  @page_name = params[:page_name]
  @folder = params[:folder]
  haml "#{@folder}/#{@page_name}".to_sym, :layout => false rescue redirect("/")
end

get '/:page_name' do
  @page_name = params[:page_name]
  haml @page_name.to_sym
end

get '/' do
  @page_name = params[:page_name]
  haml :index
end