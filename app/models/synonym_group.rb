class SynonymGroup < ApplicationRecord
	enum group_type: { synonym: "synonym", oneWaySynonym: "oneWaySynonym", altCorrection1: "altCorrection1", altCorrection2: "altCorrection2", placeholder: "placeholder" }
	has_many :synonyms, dependent: :destroy
end
