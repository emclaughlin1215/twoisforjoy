require 'rails_helper'

RSpec.describe "API Controller Requests", :type => :request do
  before do
    @user = FactoryBot.create(:test_user)
    json_headers = { "CONTENT_TYPE" => "application/json" }
    post "/api/v1/login", params: { email: @user.email, password: @user.password }.to_json, headers: json_headers
    @token = JSON.parse(response.body)['token']
    @valid_headers = { "AUTHORIZATION" => "Token token=#{@token}" }
    @invalid_headers = { "AUTHORIZATION" => "Token token=askldjf8afdjs" }
  end

  it "returns the current user" do
    current_user = User.find_by(token: @token)
    expect(current_user.name).to eq(@user.name)
  end

  it "authenticates with a correct token" do
    delete "/api/v1/logout", headers: @valid_headers
    expect(response).to have_http_status :ok
  end
  it "does not authenticate with an incorrect token" do
    delete "/api/v1/logout", headers: @invalid_headers
    expect(response).to have_http_status :unauthorized
  end
end