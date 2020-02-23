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
        puts format(
          'Service id %<service_id>i shares schedule %<schedule_id>i with Resource id %<resource_id>i',
          service_id: s.service_id,
          schedule_id: s.id,
          resource_id: s.resource_id
        )
        Schedule.create(resource_id: nil, service_id: s.service_id)
        Schedule.update(s.id, service_id: nil)
      end
      puts format('Updated %<num>i schedule records with nil service_id', num: schedules.length)
    end
  end

  # We can run this task in production for resources for HAP until we finish the frontend
  # to edit the hours_known flag.
  desc 'Mark certain resources with unknown hours'
  task mark_resource_hours_unknown: :environment do
    Resource.transaction do
      resource_names = [
        'The Q Foundation'
      ]
      Resource.where(name: resource_names).each do |r|
        Schedule.transaction do
          schedules = Schedule.where(resource_id: r.id)
          schedules.each do |s|
            puts format(
              'Marked id %<resource_id>i (%<resource_name>s) ' \
              'with schedule %<schedule_id>i as having unknown hours',
              resource_id: s.resource_id,
              resource_name: r.name,
              schedule_id: s.id
            )
            Schedule.update(s.id, hours_known: false)
          end
          puts format('Updated %<num>i schedule records with unknown hours', num: schedules.length)
        end
      end
    end
  end

  ############################################
  ## TASKS FOR HIERARCHICAL CATEGORIES WORK ##
  ############################################
  ## Steps
  ## 1. Remap resources/services under fewer categories
  #### e.g. remap resources/services under 'Prevent & Treat', 'Screening & Exams' to 'Checkup & Test',
  ## 2. Delete old category names that are now no longer used or mapped to any resource/service
  #### e.g. delete 'Prevent & Treat', 'Screening & Exams'
  ## 3. Rename categories to new names according to list provided
  #### e.g. rename 'Checkup & Test' => 'Medical Care'
  ## 4. Create new categories that were not renamed to in step 3
  
  # STEP 1: Reassign categories in resources/services 
  desc 'Reassign categories in resources and services to avoid non-unique error when renaming'
  task reassign_categories: :environment do
    reassignments = {
      'Prevent & Treat' => 'Checkup & Test',
      'Screening & Exams' => 'Checkup & Test',
      'Support Network' => 'Counseling',
      'Supplies for School' => 'Books',
      'More Education' => 'Help Find School',
      'Job Placement' => 'Skills Assessment',
      'End of Life Care' => 'Hospice',
      'Help Escape Violence' => 'Immediate Safety',
      'Domestic Violence' => 'Immediate Safety',
      'Help Pay for Internet or Phone' => 'Help Pay for Utilities',
      'Clothes for School' => 'Clothing Vouchers',
      'Clothes for Work' => 'Clothing Vouchers',
      'Help Pay for Housing' => 'Housing Vouchers',
      'Rental Assistance' => 'Housing Vouchers',
      'Vocational Training' => 'Skills & Training',
      'Eviction Prevention' => 'At Imminent Risk of Eviction',
      'Work' => 'Employment',
      'Money' => 'Financial Aid & Loans',
      'Help Pay for Transit' => 'Bus Passes'
    }
    reassignments.each do |old, new|
      old_category = Category.find_by(name: old)
      new_category = Category.find_by(name: new)
      ## Update categories for services
      #### find matching rows in categories_services and just update the category id 
      CategoriesService.transaction do
        CategoriesService.where('category_id = ?', old_category.id).update_all(category_id: new_category.id)
      end
      ## Update categories for resources
      #### find matching resources containing old categories and update it by removing the old category and adding the new one
      Resource.transaction do
        matching_resources = Resource.joins(:categories).where("categories.name = ?", old_category.name)
        matching_resources.each do |r|
          new_categories = r.categories - r.categories.select {|c| c.name == old_category.name} + [Category.find_by(name: new_category.name)]
          r.update(categories: new_categories)
        end
      end
    end
  end

  # STEP 2: Delete categories that were reassigned
  desc 'Delete categories in categories table that were reassigned'
  task delete_categories: :environment do
    Category.transaction do
      to_delete = [
        'Prevent & Treat',
        'Screening & Exams',
        'Support Network',
        'Supplies for School',
        'More Education',
        'Job Placement',
        'End of Life Care',
        'Help Escape Violence',
        'Domestic Violence',
        'Help Pay for Internet or Phone',
        'Clothes for School',
        'Clothes for Work',
        'Help Pay for Housing',
        'Rental Assistance',
        'Vocational Training',
        'Eviction Prevention',
        'Work',
        'Money',
        'Help Pay for Transit'
      ]
      to_delete.each do |c|
        Category.find_by(name: c).delete
      end
    end
  end

  # STEP 3: Rename categories to new names
  desc 'Rename certain categories to new names'
  task rename_categories: :environment do
    Category.transaction do
      renames = {
        'Transportation for Healthcare' => 'Healthcare Transportation',
        'Checkup & Test' => 'Medical Care',
        'Personal Hygiene' => 'Hygiene',
        'Counseling' => 'Counseling & Support',
        'Hospice' => 'End-of-Life Care',
        'Retirement Benefits' => 'Government Benefits',
        'Help Find Childcare' => 'Childcare',
        'Help Pay for Childcare' => 'Childcare Financial Assistance',
        'Relief for Caregivers' => 'Caregiver Relief',
        'Navigating the System' => 'Understand Government Programs',
        'Help Fill out Forms' => 'Form & Paperwork Assistance',
        'Help Find Housing' => 'Housing Counseling',
        'Help Find School' => 'Education',
        'Books' => 'School Supplies',
        'Financial Aid & Loans' => 'Finances & Benefits',
        'Help Find Work' => 'Job Placement & Skill Assessment',
        'One-on-One Support' => 'Individual Counseling',
        'Help Pay for School' => 'Education Financial Assistance',
        'Transportation for School' => 'School Transportation',
        'Skills & Training' => 'Job Training',
        'Skills Assessment' => 'Job Placement & Skill Assessment',
        'Help Pay for Work Expenses' => 'Work Expenses',
        'Home Delivered Meals' => 'Food Delivery',
        'Immediate Safety' => 'Physical Safety',
        'Free Meals' => 'Food',
        'Help Pay for Food' => 'Food Benefits',
        'Help Pay for Utilities' => 'Utilities Financial Assistance',
        'Housing Vouchers' => 'Housing Financial Assistance',
        'Public Housing' => 'Low-income Housing',
        'Safe Housing' => 'Domestic Violence Shelter',
        'Short-Term Housing' => 'Temporary Shelter',
        'Clothing Vouchers' => 'Clothing',
        'Home Goods' => 'Goods',
        'Bus Passes' => 'Transportation Financial Assistance',
        'Legal Representation' => 'Representation',
        'Legal Services' => 'Legal',
        'Adoption' => 'Adoption & Foster Care',
        'At Imminent Risk of Eviction' => 'Eviction Prevention & Defense',
        'Disaster Assistance' => 'Disaster Response',
        'Early Childhood Education' => 'Early Childhood Care',
        'Case Management' => 'Case Manager',
        'Money Management' => 'Financial Education',
        'Habitability' => 'Building Code Enforcement',
        'Help Pay for Healthcare' => 'Healthcare Financial Assistance',
        'Homelessness Essentials' => 'Basic Needs',
        'Subsidized Housing' => 'Low-income Housing',
        'Employment' => 'Employment & Jobs'
      }
      renames.each do |old, new|
        Category.find_by(name: old).update(name: new)
      end
    end
  end

  # STEP 4: Create new categories that don't exist yet for the hierarchical categories work
  desc 'Add missing categories'
  task add_new_categories_hierarchical: :environment do
    Category.transaction do
      categories = [
        'Residential Care',
        'English as a Second Language',
        'Residential Treatment',
        'Criminal Justice Involvement',
        'Hot Meals',
        'Personal Safety Items',
        'Detox',
        'Computer or Internet Access',
        'Utilities & Insurance Assistance',
        'Transition Age Youth',
        'Medication Management',
        'Haircut',
        'Mental Health Medication',
        'Health',
        'Language',
        'ADA Transit',
        'Rec Teams',
        'Traumatic Brain Injury',
        'Loans',
        'Domestic Violence Hotline',
        'STD/STI Treatment & Prevention',
        'Animal Welfare',
        'Online Only',
        'Safety Education',
        'Drop-In Center',
        'Supported Employment',
        'Fitness & Exercise',
        'Medications',
        'Addiction Medicine',
        'Sexual & Reproductive Health',
        'Probation & Parole',
        'Disability'
      ]
      categories.each do |c|
        Category.find_or_create_by(name: c)
      end
    end
  end
end