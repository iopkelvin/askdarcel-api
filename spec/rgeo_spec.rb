require 'rails_helper'

RSpec.describe "RGeo" do
  it "supports Geos" do
    expect(RGeo::Geos.supported?).to be true
  end
end
