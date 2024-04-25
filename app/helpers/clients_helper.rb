# frozen_string_literal: true

module ClientsHelper
  def client_type_options
    Client.client_types.map do |key, _value|
      [I18n.t("activerecord.attributes.client.client_types.#{key}"), key]
    end
  end

  def client_type_label(client)
    I18n.t("activerecord.attributes.client.client_types.#{client.client_type}")
  end
end
