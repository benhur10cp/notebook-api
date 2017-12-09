require 'rails_helper'

describe V1::ContactsController, type: :controller do
  # it 'resquest index and return 200 ok' do
  #   request.accept = 'application/vnd.api+json'
  #   get :index
  #   expect(response.status).to eql(200)
  # end


  it 'resquest index and return 200 ' do
    request.accept = 'application/vnd.api+json'
    get :index
    expect(response).to have_http_status(200)
  end


  it 'resquest index and return 406 ' do
    get :index
    expect(response).to have_http_status(406)
  end

end
