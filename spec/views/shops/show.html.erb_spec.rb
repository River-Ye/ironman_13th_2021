require 'rails_helper'

RSpec.describe "shops/show", type: :view do
  before(:each) do
    @shop = assign(:shop, Shop.create!(
      name: "Name",
      email: "Email",
      note: "Note"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Note/)
  end
end
