require 'spec_helper'

describe "devices/index.html.haml" do
  before(:each) do
    assign(:devices, [
      stub_model(Device),
      stub_model(Device)
    ])
  end

  it "renders a list of devices" do
    render
  end
end
