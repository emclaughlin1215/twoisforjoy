require 'rails_helper'

RSpec.describe "routes to the users controller", :type => :routing do
  it "allows access to #show" do
    expect(:get => api_v1_user_path(1)).to route_to(:controller => "api/v1/users", :action => "show", :id  => "1")
  end

  it "allows access to #edit" do
    expect(:get => edit_api_v1_user_path(1)).to route_to(:controller => "api/v1/users", :action => "edit", :id  => "1")
  end

  it "allows access to #update" do
    expect(:patch => api_v1_user_path(1)).to route_to(:controller => "api/v1/users", :action => "update", :id  => "1")
  end

  it "denies access to #destroy" do
    expect(:delete => api_v1_user_path(1)).not_to be_routable
  end
end