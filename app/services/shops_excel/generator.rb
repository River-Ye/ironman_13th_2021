# frozen_string_literal: true

module ShopsExcel
  class Generator
    TITLES = %w[商家名稱 信箱 備註].freeze
    ROW_TYPES = %i[string string string].freeze

    def execute
      shops = Shop.all
      xlsx = Axlsx::Package.new
      workbook = xlsx.workbook
      workbook.add_worksheet(name: '商家清單') do |sheet|
        sheet.add_row(TITLES)
        shops.find_each do |shop|
          sheet.add_row(shop_row_data(shop), types: ROW_TYPES)
        end
      end
      xlsx
    end

    private

    def shop_row_data(shop)
      [
        shop.name,
        shop.email,
        shop.note
      ]
    end
  end
end
