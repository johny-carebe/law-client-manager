# frozen_string_literal: true

class OpposingParty < ApplicationRecord
  belongs_to :person

  accepts_nested_attributes_for :person

  validates :person_id, presence: true, uniqueness: true

  enum client_type: { defendant: 0, plaintiff: 1 }
end
