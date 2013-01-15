require File.dirname(__FILE__) + '/../spec_helper'


describe User do
  it "should have delynn as user 1" do
    user = User.find(1)
    expect(user.name).to eq 'delynn'
  end
end