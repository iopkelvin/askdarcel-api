# frozen_string_literal: true
  
# Tasks to add default site code of 'sfsg' to all existing resources and categories

namespace :create_site do
  # create site_code of 'sfsg'
  task add_sfsg_site: :environment do
    Site.transaction do
      Site.find_or_create_by(site_code: 'sfsg')
    end
  end
  
  # to each resource, add a connection using resource_site
  task add_sfsg_to_resources: :environment do
    sfsg = Site.where(side_code: 'sfsg')
    Resource.all.each do |r|
      # for each resource, we want to create a connection through intermediate table resource_site
      r.update!(site_id: sfsg.id)
    end
  end

  # to each category, add a connection using category_site
  task add_sfsg_to_categories: :environment do
    sfsg = Site.where(side_code: 'sfsg')
    Category.all.each do |c|
      # for each category, we want to create a connection through intermediate table category_site
      c.update!(site_id: sfsg.id)
    end
  end
end
