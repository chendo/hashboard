require 'spec_helper'

describe "devices/edit.html.haml" do
  before(:each) do
    @device = assign(:device, stub_model(Device,
      :new_record? => false
    ))
  end

  it "renders the edit device form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => device_path(@device), :method => "post" do
    end
  end
end
