# frozen_string_literal: true

module ApplicationHelper
  def formatted_document(document)
    case document&.length
    when 11
      CPF.new(document).formatted
    when 14
      CNPJ.new(document).formatted
    else
      document
    end
  end

  def formatted_rg(rg) # rubocop:disable Naming/MethodParameterName
    return rg if rg.blank?

    rg = rg.rjust(9, '0') if rg.length < 9

    "#{rg[0..1]}.#{rg[2..4]}.#{rg[5..7]}-#{rg[8..]}"
  end

  def formatted_ctps(ctps)
    return ctps if ctps.blank?

    ctps = ctps.rjust(11, '0') if ctps.length < 11

    "#{ctps[0..6]}/#{ctps[7..]}"
  end

  def flash_class(key)
    case key.to_sym
    when :success
      'alert-success'
    when :error
      'alert-error'
    else
      'alert-info'
    end
  end
end
