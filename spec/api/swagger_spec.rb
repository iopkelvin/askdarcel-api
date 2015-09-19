require 'rails_helper'

RSpec.describe 'the API', type: :apivore, order: :defined do
  subject { Apivore::SwaggerChecker.instance_for('/v1/swagger.json') }

  describe 'resource endpoints' do
    before do
      FactoryGirl.create_list(:resource, 10)
    end
    it { is_expected.to validate( :get, '/resources', 200, "_query_string" => "page=2&per_page=2" ) }
    it { is_expected.to validate( :get, '/resources/{id}', 200, 'id' => Resource.first.id ) }
  end

  describe 'category endpoints' do
    before do
      FactoryGirl.create_list(:category, 10)
    end

    it { is_expected.to validate( :get, '/categories', 200 ) }
    it { is_expected.to validate( :get, '/categories/{id}', 200, 'id' => Category.first.id ) }
  end

  describe 'routes' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
