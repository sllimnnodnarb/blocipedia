require 'rails_helper'
Devise::Test::UsersController

RSpec.describe UsersController, type: :controller do

  let(:new_user_attributes) do
    {
      email: "blochead@bloc.io",
      password: "blochead",
      password_confirmation: "blochead"
    }
  end

  describe "GET new" do
    it "returns http success" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end

  describe "POST create" do
    it "returns an http redirect" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end
    it "creates a new user" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      expect{
        post :create, user: new_user_attributes
      }.to change(User, :count).by(1)
    end
    it "sets user name properly" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
      expect(assigns(:user).name).to eq new_user_attributes[:email]
    end
    it "sets user email properly" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end
    it "sets user password properly" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end
    it "logs the user in after sign up" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq assigns(:user).id
    end
    it "sets user password_confirmation properly" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end
  end

  describe "not signed in" do
    let(:factory_user) { create(:user) }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      post :create, user: new_user_attributes
    end

    it "returns http success" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      get :show, {id: factory_user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      get :show, {id: factory_user.id}
      expect(response).to render_template :show
    end

    it "assigns factory_user to @user" do
      @request.env['devise.mapping'] = Devise.mappings[:users]
      get :show, {id: factory_user.id}
      expect(assigns(:user)).to eq(factory_user)
    end
  end

end
