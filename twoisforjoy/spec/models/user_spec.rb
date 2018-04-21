require 'rails_helper'

RSpec.describe User, :type => :user do
  before(:each) do
    @user = described_class.new(name: "Test",
                                email: "test@example.com",
                                password: "testtest",
                                password_confirmation: "testtest")
  end

  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end

  it "is not valid with blank name" do
    @user.name = ""
    expect(@user).to_not be_valid
  end

  it "is not valid with mismatched passwords" do
    @user.password = "testest"
    @user.password_confirmation = "testtest"
    expect(@user).to_not be_valid
  end

  it "is not valid with blank email" do
    @user.email = ""
    expect(@user).to_not be_valid
  end
end