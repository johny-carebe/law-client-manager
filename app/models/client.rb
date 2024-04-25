# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :person, required: false

  accepts_nested_attributes_for :person

  validates :person_id, presence: true, uniqueness: true

  enum client_type: { defendant: 0, plaintiff: 1 }
end
