# frozen_string_literal: true

require 'json'

namespace :synonyms do
  task populate: :environment do
    puts '[synonyms:populate] Incorporating synonyms from JSON...'

    algolia_synonyms_json = File.join(File.dirname(__FILE__), 'algolia-synonyms.json')
    synonyms = File.open(algolia_synonyms_json) do |f|
      JSON.parse(f.read)
    end

    Synonym.inheritance_column = :_type_disabled # to avoid getting error when using the type column: "ActiveRecord::SubclassNotFound: The single-table inheritance mechanism failed to locate the subclass: 'synonym'"
    synonyms.each do |syn|
      Synonym.create(syn.to_h)
    end
    Synonym.inheritance_column = :type # switch on the Rails STI after you've made your updates to the DB columns

    puts '[synonyms:populate] Success.'
  end
end
