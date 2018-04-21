require 'rails_helper'

RSpec.describe "Sessions Requests", :type => :request do
  before do
    @user = FactoryBot.create(:test_user)
    @headers = { "CONTENT_TYPE" => "application/json" }
  end

  it "allows access to #create by anon users and returns token on valid login" do
    post "/api/v1/login", params: { email: @user.email, password: @user.password }.to_json, headers: @headers
    expect(response.content_type).to eq "application/json"
    expect(response).to have_http_status :ok
    json = JSON.parse(response.body)
    expect(json['token']).to_not be_nil
    expect(@user.token).to_not be_nil
    token = JSON.parse(response.body)['token']
    headers = { "AUTHORIZATION" => "Token token=#{token}" }
    delete "/api/v1/logout", headers: headers
    expect(response).to have_http_status :ok
  end

  it "returns error on invalid login" do
    post "/api/v1/login", params: { email: @user.email, password: "testest" }.to_json, headers: @headers
    expect(response.content_type).to eq "application/json"
    expect(response).to have_http_status :unauthorized
    json = JSON.parse(response.body)
    expect(json['errors']).to_not be_nil
    expect(json['errors'].first['detail']).to eq("Error with your login or password")
    delete "/api/v1/logout"
    expect(response).to have_http_status :unauthorized
  end

  it "denies access to #destroy by anon users" do
    delete "/api/v1/logout"
    expect(response).to have_http_status :unauthorized
  end

  it "allows access to #destroy by authenticated users and destroys session" do
    post "/api/v1/login", params: { email: @user.email, password: @user.password }.to_json, headers: @headers
    token = JSON.parse(response.body)['token']
    headers = { "AUTHORIZATION" => "Token token=#{token}" }
    delete "/api/v1/logout", headers: headers
    expect(response).to have_http_status(:ok)
    delete "/api/v1/logout", headers: headers
    expect(response).to have_http_status(:unauthorized)
  end
end