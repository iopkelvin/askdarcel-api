# frozen_string_literal: true

class AddressesPresenter < Jsonite
  property :address, with: AddressPresenter
end
