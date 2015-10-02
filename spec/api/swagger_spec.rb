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

  describe 'ratings endpoints' do
    let(:device_id) { '1234' }

    context 'collection endpoints' do
      it do
        FactoryGirl.create_list(:resource,
                                10,
                                ratings_count: 0,
                                ratings: [FactoryGirl.create(:rating, device_id: device_id)]
                               )
        is_expected.to validate(:get,
                                '/ratings',
                                200,
                                "_query_string" => "page=2&per_page=2",
                                "_headers" => { 'DEVICE-ID' => device_id })
      end

      it do
        resource = FactoryGirl.create(:resource, ratings_count: 0)
        is_expected.to validate(:post,
                                '/ratings',
                                201,
                                "_data" => {
                                  "rating" => {
                                    'resource_id' => resource.id,
                                    'rating_option_name' => 'positive'
                                  }
                                },
                                "_headers" => { 'DEVICE-ID' => device_id })
      end
    end

    context 'resource endpoints' do
      let(:rating) do
        resource.ratings.first
      end

      let(:resource) do
        FactoryGirl.create(:resource,
                           ratings_count: 0,
                           ratings: [FactoryGirl.create(:rating, device_id: device_id)])
      end


      it do
        is_expected.to validate(:delete,
                                '/ratings/{id}',
                                204,
                                'id' => rating.id,
                                "_headers" => { 'DEVICE-ID' => device_id })
      end

      it do
        is_expected.to validate(:get,
                                '/ratings/{id}',
                                200,
                                'id' => rating.id,
                                "_headers" => { 'DEVICE-ID' => device_id })
      end

      it do
        is_expected.to validate(
          :put,
          '/ratings/{id}',
          200,
          "_data" => {
            "rating" => { resource_id: resource.id, rating_option_name: 'positive' }
          },
          "_headers" => { 'DEVICE-ID' => device_id },
          'id' => rating.id,
        )
      end
    end
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
