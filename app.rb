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
  unless params[:name].upcase == 'PIC'
    invitee = code_lookup(params[:name])
    haml :index_new, :locals => {:invitee => invitee}
  else
    redirect 'https://drive.google.com/folderview?id=0ByYtaxSgj51BfmN0cnFoS09YOTFRbnZfU0pIbUZPcHBQVWFSdXhwYmFrYWxGM2h4VUEySUE&usp=sharing'
  end
end

get '/' do
  haml :root
end
