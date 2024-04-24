# frozen_string_literal: true

class PersonsController < ApplicationController
  def index
    @persons = Person.paginate(page: params[:page], per_page: 10)

    return unless params[:search].present?

    @persons = @persons.where(
      'name LIKE ? OR cpf LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%"
    )
  end

  def show
    @person = Person.find(params[:id])
  end
end
