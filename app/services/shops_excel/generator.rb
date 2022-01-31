# frozen_string_literal: true

module ShopsExcel
  class Generator
    TITLES = %w[商家名稱 信箱 備註].freeze
    ROW_TYPES = %i[string string string].freeze
    LINK_PATTERN = /\A\[(.*)\]\((http.*)\)\z/ # 針對資料 "[data](https://riverye.com/shops/id)"，過濾成 data 和 https://riverye.com/shops/id

    def execute
      shops = Shop.all
      xlsx = Axlsx::Package.new
      workbook = xlsx.workbook
      workbook.add_worksheet(name: '商家清單') do |sheet|
        sheet.add_row(TITLES)
        shops.find_each do |shop|
          row_data = shop_row_data(shop)
          links = check_link(row_data)
          cur_row = sheet.add_row(row_data, types: ROW_TYPES)
          add_link(sheet, links, cur_row) if links.present?
        end
      end
      xlsx
    end

    private

    def shop_row_data(shop)
      [
        "[#{shop.name}](https://riverye.com/shops/#{shop.id})",
        shop.email,
        shop.note
      ]
    end

    def check_link(row_data)
      row_data.each_with_index.map do |data, index|
        if data.is_a?(String) && matched = data.match(LINK_PATTERN)
          row_data[index] = matched[1]
          [index, matched[2]]
        end
      end.compact
    end

    def add_link(sheet, links, cur_row)
      links.map do |index, link|
        sheet.add_hyperlink(location: link, ref: sheet.rows[cur_row.row_index].cells[index])
      end
    end
  end
end
