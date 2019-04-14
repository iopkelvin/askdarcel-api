# frozen_string_literal: true

# Tasks that should be run once to alter data in production.

namespace :onetime do
  # Add new categories.
  #
  # This is idempotent so it is safe to run more than once
  task add_new_categories: :environment do
    Category.transaction do
      categories = [
        'Family Shelters',
        'Domestic Violence Shelters',
        'Advocacy & Legal Aid',
        'Eviction Defense',
        'Housing/Tenants Rights',
        'Youth',
        'Seniors',
        'End of Life Care',
        'Home Delivered Meals',
        'Senior Centers',
        'Congregate Meals',
        'Housing Rights',
        'Eviction Defense',
        'Domestic Violence',
        'Legal Representation',
        'Prison/Jail Related Services',
        'Legal Services',
        'Domestic Violence',
        'Domestic Violence Shelters',
        'Domestic Violence Hotlines',
        'Legal Representation',
        'Prison/Jail Related Services',
        'Re-entry Services',
        'Clean Slate',
        'Probation and Parole',
        'Legal Services'
      ]
      categories.each do |c|
        Category.find_or_create_by(name: c)
      end
    end
  end

  # A service should never point to the same schedule as a resource.
  # If it shares a schedule with its resource, it shouldn't have its own schedule row.
  desc 'Ensure services that inherit resource schedules do not have their own schedule'
  task fix_service_schedule_inheritance: :environment do
    Schedule.transaction do
      schedules = Schedule.joins(:service).joins('INNER JOIN resources ' \
          'ON resources.id = services.resource_id ' \
          'AND resources.id = schedules.resource_id')
      schedules.each do |s|
        puts 'Service id %i shares schedule %i with Resource id %i' % [s.service_id, s.id, s.resource_id]
        Schedule.update(s.id, :service_id => nil)
      end
      puts 'Updated %i schedule records with nil service_id' % [schedules.length]
    end
  end

end
