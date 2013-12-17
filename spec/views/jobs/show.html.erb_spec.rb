require 'spec_helper'

describe "jobs/show" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :title => "Title",
      :location => "Location",
      :description => "MyText",
      :contact => "MyText",
      :company => "Company",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Location/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Company/)
    rendered.should match(/Url/)
  end
end
