# frozen_string_literal: true

class OpposingPartiesController < ApplicationController
  def index
    @opposing_parties = OpposingParty.paginate(page: params[:page], per_page: 10)

    return unless params[:search].present?

    find_opposing_party
  end

  def new
    @people = Person.order(:name)
    @opposing_party = OpposingParty.new
  end

  def create
    @people = Person.order(:name)
    @opposing_party = OpposingParty.new(opposing_party_params)

    if @opposing_party.save
      flash[:success] = t('.success')
      return redirect_to(opposing_parties_path)
    end

    flash_error_and_redirect(@opposing_party, new_opposing_party_path)
  end

  def edit
    @people = Person.order(:name)
    @opposing_party = OpposingParty.find(params[:id])
  end

  def update
    @people = Person.order(:name)
    @opposing_party = OpposingParty.find(params[:id])

    if @opposing_party.update(opposing_party_params)
      flash[:success] = t('.success')
      return redirect_to(opposing_parties_path)
    end

    flash_error_and_redirect(@opposing_party, edit_opposing_party_path(@opposing_party))
  end

  def destroy
    @opposing_party = OpposingParty.find(params[:id])

    if @opposing_party.delete
      flash[:success] = t('.success')
      return redirect_to(opposing_parties_path)
    end

    flash_error_and_redirect(
      @opposing_party,
      opposing_parties_path(search: @opposing_party.person.cpf_cnpj)
    )
  end

  def edit_client_type
    @opposing_party = OpposingParty.find(params[:id])
    @opposing_party.client_type = params[:client_type]
    @opposing_party.save

    redirect_back(fallback_location: root_path)
  end

  private

  def find_opposing_party
    cpf_cnpj_hash = { cpf_cnpj: params[:search] }
    cpf_cnpj = format_cpf_cnpj(cpf_cnpj_hash)

    if cpf_cnpj.blank?
      @opposing_parties =
        @opposing_parties
        .joins(:person)
        .where('people.name ILIKE ?', "%#{params[:search]}%")

      return
    end

    @opposing_parties = @opposing_parties.joins(:person).where(people: { cpf_cnpj: })
  end

  def format_cpf_cnpj(cpf_cnpj_hash)
    LawClientManager::Person::DocumentFormatter
      .new(cpf_cnpj_hash)
      .cpf_cnpj
      .format[:cpf_cnpj]
  end

  def opposing_party_params
    params.require(:opposing_party).permit(
      :client_type,
      :person_id
    )
  end

  def flash_error_and_redirect(opposing_party, path)
    flash[:error] = opposing_party.errors.full_messages.join(', ')
    redirect_to(path)
  end
end
