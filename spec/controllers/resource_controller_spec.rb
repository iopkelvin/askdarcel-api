require 'rails_helper'

RSpec.describe ResourcesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "filters by category names" do
      resource1 = FactoryGirl.create(:resource)
      resource2 = FactoryGirl.create(:resource)

      get :index, category_names: [resource1.categories.first.name]
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body["resources"].length).to eql(1)
      expect(body["resources"][0]["categories"].map { |c| c["name"] }).to eql(resource1.categories.map(&:name))
    end

    it "filters by category ids" do
      resource1 = FactoryGirl.create(:resource)
      resource2 = FactoryGirl.create(:resource)

      get :index, category_ids: [resource1.categories.first.id]
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body["resources"].length).to eql(1)
      expect(body["resources"][0]["categories"].map { |c| c["name"] }).to eql(resource1.categories.map(&:name))
    end
  end
end
