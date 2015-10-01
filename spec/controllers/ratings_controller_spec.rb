require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  context 'device id is specified' do

    let(:device_id) { '1234' }
    before do
      request.headers['DEVICE-ID'] = device_id
    end

    describe 'POST #create' do
      context 'device has not yet rated the resource' do
        it 'creates a new rating' do
          resource = FactoryGirl.create(:resource)

          post :create,
               { rating: { resource_id: resource.id, rating_option: { name: 'positive' } } }

          expect(response).to have_http_status(:created)
          body = JSON.parse(response.body)
          body['rating']['rating_option']['name'] = 'positive'
        end
      end

      context 'device has rated the resource' do
        it 'returns a unprocessable_entity' do
          resource = FactoryGirl.create(:resource)
          rating = FactoryGirl.create(:rating, resource_id: resource.id, device_id: device_id)

          post :create, rating: { resource_id: resource.id, rating_option: { name: 'positive' } }

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'PUT #update' do
      context 'rating does not exist' do
        it 'returns 404' do
          resource = FactoryGirl.create(:resource)

          put :update, id: 89374, rating: { resource_id: resource.id, rating_option: { name: 'positive' } }

          expect(response).to have_http_status(:not_found)
        end
      end

      context 'rating exists' do
        it 'updates the rating' do
          resource = FactoryGirl.create(:resource)
          rating = FactoryGirl.create(:rating, resource_id: resource.id, device_id: device_id, rating_option: RatingOption.find_by(name: 'negative'))

          put :update, id: rating.id, rating: { resource_id: resource.id, rating_option: { name: 'positive' } }

          expect(response).to have_http_status(:success)
          body = JSON.parse(response.body)
          body['rating']['rating_option']['name'] = 'positive'
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'rating does not exist' do
        it 'returns 404' do
          resource = FactoryGirl.create(:resource)

          delete :destroy, id: 89374, rating: { resource_id: resource.id, rating_option: { name: 'positive' } }

          expect(response).to have_http_status(:not_found)
        end
      end

      context 'rating exists' do
        it 'destroys the rating' do
          resource = FactoryGirl.create(:resource)
          rating = FactoryGirl.create(:rating, resource_id: resource.id, device_id: device_id, rating_option: RatingOption.find_by(name: 'negative'))

          expect {
            delete :destroy, id: rating.id
          }.to change { Rating.count }.by(-1)

          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end

  context 'device id is not specified' do
    it 'returns unprocessable entity' do
      post :create, {}

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
