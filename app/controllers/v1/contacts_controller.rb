module V1
  class ContactsController < ApplicationController
    include ErrorSerializer
    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /contacts
    def index
      @contacts = Contact.all.page(params.dig(:page, :number) ? params[:page][:number] : 1).per(params[:page].try(:[], :size))

      # cache control expires_in 30.seconds, puclic: true
      #paginate json: @contacts #, methods: :name_complete #.map {|contact| contact.attributes.merge({ name_complete: contact.name + " " + contact.email })} #only: [:name, :email] #root: true

      #if stale?(etag: @contacts)

      #if stale?(last_modified: @contacts[0].updated_at)
      render json: @contacts
      #end

      #render json: @contacts #, methods: :name_complete #.map {|contact| contact.attributes.merge({ name_complete: contact.name + " " + contact.email })} #only: [:name, :email] #root: true
    end

    # GET /contacts/1
    def show
      render json: @contact #, include: [:kind, :address, :phones] #, meta: {author: 'TESTE'} #, include: [:kind, :phones, :address]#.to_br #.attributes.merge({ name_complete: @contact.name + " " + @contact.email })
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
      else
        #render json: @contact.errors, status: :unprocessable_entity
        render json: ErrorSerializer.serialize(@contact.errors)
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [:kind, :phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      # params.require(:contact).permit(:name, :email, :birthdate, :kind_id,
      # phones_attributes: [:id, :number, :_destroy],
      # address_attributes: [:id, :street, :city])
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
  end
end