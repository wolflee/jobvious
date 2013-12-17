require 'spec_helper'

describe "jobs/edit" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :title => "MyString",
      :location => "MyString",
      :description => "MyText",
      :contact => "MyText",
      :company => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", job_path(@job), "post" do
      assert_select "input#job_title[name=?]", "job[title]"
      assert_select "input#job_location[name=?]", "job[location]"
      assert_select "textarea#job_description[name=?]", "job[description]"
      assert_select "textarea#job_contact[name=?]", "job[contact]"
      assert_select "input#job_company[name=?]", "job[company]"
      assert_select "input#job_url[name=?]", "job[url]"
    end
  end
end
