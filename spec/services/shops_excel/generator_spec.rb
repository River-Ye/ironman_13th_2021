# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShopsExcel::Generator do
  subject { described_class.new.execute }

  before do
    @shop = create(:shop)
  end

  it 'generate rows correctly' do
    xlsx = subject
    first_sheet = xlsx.workbook.worksheets[0]
    expect(first_sheet.name).to eq('商家清單')
    expect(first_sheet.rows[0].cells.map(&:value)).to match_array(
      %w[商家名稱 信箱 備註]
    )
    expect(first_sheet.rows[1].cells.map(&:value)).to match_array(
      [@shop.name, @shop.email, @shop.note]
    )
    # 驗證: 超連結
    expect_hyperlink = [first_sheet.hyperlinks.first.location, first_sheet.hyperlinks.first.ref]
    expect(expect_hyperlink).to match_array(
      ["https://riverye.com/shops/#{@shop.id}", 'A2']
    )
    # 驗證: 顏色
    expect(first_sheet.rows[1].cells.map(&:color).map { |d| d&.rgb }).to match_array(
      ['FF0000FF', nil, nil]
    )
    # 驗證: 底線
    expect(first_sheet.rows[1].cells.map(&:u)).to match_array(
      [:single, nil, nil]
    )
  end
end
