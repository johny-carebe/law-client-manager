# frozen_string_literal: true

class ClientsController < ApplicationController
  def index
    @clients = Client.paginate(page: params[:page], per_page: 10)

    return unless params[:search].present?

    find_client
  end

  def new
    @people = Person.order(:name)
    @client = Client.new
  end

  def create
    @people = Person.order(:name)
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = t('.success')
      return redirect_to(clients_path)
    end

    flash_error_and_redirect(@client, new_client_path)
  end

  def edit
    @people = Person.order(:name)
    @client = Client.find(params[:id])
  end

  def update
    @people = Person.order(:name)
    @client = Client.find(params[:id])

    if @client.update(client_params)
      flash[:success] = t('.success')
      return redirect_to(clients_path)
    end

    flash_error_and_redirect(@client, edit_client_path(@client))
  end

  def destroy
    @client = Client.find(params[:id])

    if @client.delete
      flash[:success] = t('.success')
      return redirect_to(clients_path)
    end

    flash_error_and_redirect(@client, clients_path(search: @client.person.cpf_cnpj))
  end

  def edit_client_type
    @client = Client.find(params[:id])
    @client.client_type = params[:client_type]
    @client.save

    redirect_back(fallback_location: root_path)
  end

  private

  def find_client
    cpf_cnpj_hash = { cpf_cnpj: params[:search] }
    cpf_cnpj = LawClientManager::Person::DocumentFormatter.new(cpf_cnpj_hash)
                                                          .cpf_cnpj
                                                          .format[:cpf_cnpj]

    if cpf_cnpj.blank?
      @clients =
        @clients.joins(:person).where('people.name ILIKE ?', "%#{params[:search]}%")

      return
    end

    @clients = @clients.joins(:person).where(people: { cpf_cnpj: })
  end

  def client_params
    params.require(:client).permit(
      :client_type,
      :person_id
    )
  end

  def flash_error_and_redirect(client, path)
    flash[:error] = client.errors.full_messages.join(', ')
    redirect_to(path)
  end
end
