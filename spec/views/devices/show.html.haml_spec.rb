require 'spec_helper'

describe "devices/show.html.haml" do
  before(:each) do
    @device = assign(:device, stub_model(Device))
  end

  it "renders attributes in <p>" do
    render
  end
end
