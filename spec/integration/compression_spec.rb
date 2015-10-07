require 'rails_helper'

RSpec.describe 'Compression', type: :request do
  context 'a visitor has a browser that supports compression' do
    it 'compresses the response' do
      ['deflate', 'gzip', 'deflate,gzip', 'gzip,deflate'].each do|compression_method|
        get '/v1/resources', {}, 'HTTP_ACCEPT_ENCODING' => compression_method
        expect(response.headers['Content-Encoding']).to be
      end
    end
  end

  context 'a visitor does not have a browser that supports compression' do
    it 'does not compress the response' do
      get '/v1/resources'
      expect(response.headers['Content-Encoding']).to_not be
    end
  end
end
