class ResourcesPresenter < Jsonite
  property :id
  property :name
  property :short_description
  property :long_description
  property :website
  property :services, with: ServicesPresenter
  property :schedule, with: SchedulesPresenter
  property :phones, with: PhonesPresenter
  property :addresses, with: AddressesPresenter
  property :notes, with: NotesPresenter
  property :categories, with: CategoriesPresenter
end
