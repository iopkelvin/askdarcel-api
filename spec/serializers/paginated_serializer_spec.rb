require 'rails_helper'

RSpec.describe PaginatedSerializer, type: :serializer do
  describe 'meta tag' do
    before do
      FactoryGirl.create_list(:resource, 3)
    end

    let(:resources) { Resource.page(2).per(1) }
    let(:serializer) do
      PaginatedSerializer.new(resources, context: OpenStruct.new(url: 'http://localhost/v1/resources?page=2&category=foo'))
    end
    let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }
    let(:response) { JSON.parse(serialization.to_json) }

    it 'includes the meta object' do
      expect(response['meta']).to be
    end

    it 'includes previous page index' do
      expect(response['meta']['prev_page']).to eql(1)
    end

    it 'includes next page index' do
      expect(response['meta']['next_page']).to eql(3)
    end

    it 'includes self page url' do
      expect(response['meta']['self']).to eql('http://localhost/v1/resources?page=2&category=foo')
    end

    it 'includes next page url' do
      expect(response['meta']['next_url']).to eql('http://localhost/v1/resources?page=3&category=foo')
    end

    it 'includes prev page url' do
      expect(response['meta']['prev_url']).to eql('http://localhost/v1/resources?page=1&category=foo')
    end
  end
end
