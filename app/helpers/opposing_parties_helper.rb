# frozen_string_literal: true

module OpposingPartiesHelper
  def client_type_options
    Client.client_types.map do |key, _value|
      [I18n.t("activerecord.attributes.opposing_party.client_types.#{key}"), key]
    end
  end

  def client_type_label(opposing_party)
    I18n.t(
      "activerecord.attributes.opposing_party.client_types.#{opposing_party.client_type}"
    )
  end
end
