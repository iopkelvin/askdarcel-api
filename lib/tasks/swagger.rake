namespace :swagger do
  desc "convert swagger.yaml to swagger.json"
  task convert: :environment do
    File.open("#{Rails.root}/config/swagger.yaml", "r") do |yaml|
      File.open("#{Rails.root}/public/v1/swagger.json", 'w') do |json|
        json.write(JSON.pretty_generate(YAML::load(yaml.read)))
      end
    end
  end
end
