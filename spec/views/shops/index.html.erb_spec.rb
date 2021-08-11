require 'rails_helper'

RSpec.describe "shops/index", type: :view do
  before(:each) do
    assign(:shops, [
      Shop.create!(
        name: "Name",
        email: "Email",
        note: "Note"
      ),
      Shop.create!(
        name: "Name",
        email: "Email",
        note: "Note"
      )
    ])
  end

  it "renders a list of shops" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "Note".to_s, count: 2
  end
end
