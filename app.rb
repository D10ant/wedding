require 'sinatra'
require 'yaml'
require 'haml'

#Import YAML file that describes hash indexes
def YamlImport(yaml_file)
  parsed = begin
    YAML.load(File.open(yaml_file))
  rescue ArgumentError => e
    puts "Could not parse YAML: #{e.message}"
  end
end

#Lookup invitee name based on code
def code_lookup(code)
  invitees = YamlImport('invitees.yml')
  return invitees.fetch(code.upcase)['name']
end

get '/:name' do
  pictures = 'CODE'
  unless params[:name].upcase == pictures
    invitee = code_lookup(params[:name])
    haml :index_new, :locals => {:invitee => invitee}
  else
    redirect 'PLACE_HOLDER'
end

get '/' do
  haml :root
end
