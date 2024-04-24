# frozen_string_literal: true

module PeopleHelper
  def marital_status_options
    Person.marital_statuses.map do |key, _value|
      [I18n.t("activerecord.attributes.person.marital_statuses.#{key}"), key]
    end
  end

  def marital_status_label(person)
    I18n.t("activerecord.attributes.person.marital_statuses.#{person.marital_status}")
  end
end
