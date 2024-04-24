# frozen_string_literal: true

class PeopleController < ApplicationController
  def index
    @people = Person.paginate(page: params[:page], per_page: 10)

    return unless params[:search].present?

    find_person
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(format_params)

    if @person.save
      flash[:success] = t('.success')
      return redirect_to(people_path)
    end

    flash_error_and_redirect(@person, new_person_path)
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(format_params)
      flash[:success] = t('.success')
      return redirect_to(people_path)
    end

    flash_error_and_redirect(@person, edit_person_path(@person))
  end

  def destroy
    @person = Person.find(params[:id])

    if @person.delete
      flash[:success] = t('.success')
      return redirect_to(people_path)
    end

    flash_error_and_redirect(@person, people_path(search: @person.cpf_cnpj))
  end

  private

  def format_params
    LawClientManager::Person::DocumentFormatter
      .new(person_params)
      .cpf_cnpj
      .rg
      .ctps
      .pis_init
      .format
  end

  def person_params
    params.require(:person).permit(
      :cpf_cnpj, :ctps, :email, :full_address, :marital_status, :name, :ocupation, :phone,
      :pis_init, :rg
    )
  end

  def flash_error_and_redirect(person, path)
    flash[:error] = t('.error', errors: person.errors.full_messages.join(', '))
    redirect_to(path)
  end

  def find_person
    cpf_cnpj_hash = { cpf_cnpj: params[:search] }
    cpf_cnpj = LawClientManager::Person::DocumentFormatter.new(cpf_cnpj_hash)
                                                          .cpf_cnpj
                                                          .format[:cpf_cnpj]

    if cpf_cnpj.blank?
      @people = @people.where(name: params[:search])
      return
    end

    @people = @people.where(cpf_cnpj:)
  end
end
