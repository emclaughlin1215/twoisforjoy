require 'rails_helper'

RSpec.describe "Users Controller Requests" do
  context "anon user" do
    it "denies access to update" do
      patch api_v1_user_path(1)
      expect(response).to have_http_status :unauthorized
    end

    describe "#show" do
      before do
        @user = FactoryBot.create(:test_user)
      end

      it "allows access to show and returns user on valid id" do
        get api_v1_user_path(@user.id)
        expect(response).to have_http_status :ok
        json = JSON.parse(response.body)
        expect(json['user']).to_not be_nil
        expect(json['errors']).to be_nil
      end

      it "returns error on invalid id" do
        get api_v1_user_path(666)
        expect(response).to have_http_status :ok
        json = JSON.parse(response.body)
        expect(json['user']).to be_nil
        expect(json['errors']).to_not be_nil
      end

      it "doesn't display passwords or password_confirmations" do
        get api_v1_user_path(@user.id)
        json = JSON.parse(response.body)
        expect(json['user']['name']).to_not be_nil
        expect(json['user']['password']).to be_nil
        expect(json['user']['password_confirmation']).to be_nil
      end
    end
  end

  context "auth user" do
    before do
      @user = FactoryBot.create(:test_user)
      json_headers = { "CONTENT_TYPE" => "application/json" }
      post "/api/v1/login", params: { email: @user.email, password: @user.password }.to_json, headers: json_headers
      @token = JSON.parse(response.body)['token']
      @valid_headers = { "AUTHORIZATION" => "Token token=#{@token}", "CONTENT_TYPE" => "application/json" }
      @edited_json = { user: { name: "Test Name" } }
    end

    describe "#update" do
      it "allows update and returns user data on valid id" do
        patch api_v1_user_path(@user.id), params: @edited_json.to_json, headers: @valid_headers
        expect(response).to have_http_status :ok
        json = JSON.parse(response.body)
        expect(json['user']['name']).to eq("Test Name")
        expect(json['user']['email']).to eq(@user.email)
      end

      it "returns error on invalid id" do
        patch api_v1_user_path(666), params: @edited_json.to_json, headers: @valid_headers
        expect(response).to have_http_status :ok
        json = JSON.parse(response.body)
        expect(json['user']).to be_nil
        expect(json['errors']).to_not be_nil
      end

      it "returns error on valid id with invalid params" do
        invalid_json = { user: { name: "" } }
        patch api_v1_user_path(@user.id), params: invalid_json.to_json, headers: @valid_headers
        expect(response).to have_http_status :ok
        json = JSON.parse(response.body)
        expect(json['user']).to be_nil
        expect(json['errors']).to_not be_nil
      end
    end
  end
end