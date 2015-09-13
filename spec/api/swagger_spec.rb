require 'rails_helper'

RSpec.describe 'the API', type: :apivore, order: :defined do
  let(:params) { { "id" => 1 } }
  subject { Apivore::SwaggerChecker.instance_for('/v1/swagger.json') }

  before do
    category = Category.create(id: 1, name: "Some category")
    image = ResourceImage.new(id: 1, caption: "Apple", photo: File.open('spec/fixtures/apple.png'))
    Resource.create(id: 1, title: "Some resource", categories: [category], resource_images: [image])
  end

  it { is_expected.to validate( :get, '/resources', 200, params ) }
  it { is_expected.to validate( :get, '/resources/{id}', 200, params ) }

  it { is_expected.to validate( :get, '/categories', 200, params ) }
  it { is_expected.to validate( :get, '/categories/{id}', 200, params ) }

  it 'tests all documented routes' do
    expect(subject).to validate_all_paths
  end
end
