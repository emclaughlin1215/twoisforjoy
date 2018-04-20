require 'rails_helper'

RSpec.describe "routes to the sessions controller", :type => :routing do
  it "allows access to #create" do
    expect(:post => api_v1_login_path).to route_to(:controller => "api/v1/sessions", :action => "create")
  end

  it "allows access to #destroy" do
    expect(:delete => api_v1_logout_path).to route_to(:controller => "api/v1/sessions", :action => "destroy")
  end
end