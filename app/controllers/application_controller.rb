# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do
    head :bad_request
  end

  before_action :cachable
  before_action :set_raven_context

  def cachable
    expires_in 1.second, public: true, must_revalidate: false
  end

  # Update AirTable with a resource's 'name', 'status' & 'updated_at'
  def update_in_airtable(resource)
    puts resource.id.to_s
    airtable_orgs = AirTableOrgs.all(filter: "{ID} = " + resource.id.to_s)
    if airtable_orgs[0]
      puts airtable_orgs[0].id.to_s
      org = AirTableOrgs.find(airtable_orgs[0].id)
      org["Organization Name"] = resource.name
      org["DB Status"] = resource.status
      org["Last Modified (DB)"] = resource.updated_at
      org.save
    else
      AirTableOrgs.create("ID" => resource.id,
        "Organization Name" => resource.name,
        "DB Status" => resource.status,
        "Last Modified (DB)" => resource.updated_at,
        "Created At (DB)" => resource.created_at)
    end
  rescue StandardError => e
    puts 'failed to update resource ' + resource.id.to_s + ' to airtable: ' + e.to_s
  end

  private

  def require_authorization!
    head :unauthorized unless current_user
  end

  def current_user
    return @current_user if defined? @current_user

    user_id = request.headers['Authorization']
    @current_user = User.where(id: user_id).first
  end

  def set_raven_context
    Raven.user_context(id: current_user.id) if current_user
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
