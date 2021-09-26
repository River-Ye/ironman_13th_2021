# frozen_string_literal: true

module ShopsExcel
  class ParseError < StandardError; end

  class Parser
    def execute(file_path)
      list = read_excel(file_path)
      sheet = list.sheet(0)
      validate_title_names!(sheet)
      validate_shop_names!(sheet)
      process_shops(sheet)
    rescue ParseError => e
      subject = "[#{self.class} Error] #{e.message}, \nbacktrace: #{e.backtrace}"
      Rails.logger.error subject
    end

    private

    def read_excel(file_path)
      Roo::Spreadsheet.open(file_path)
    end

    def validate_title_names!(sheet)
      return if sheet.row(1) == ShopsExcel::Generator::TITLES

      raise ParseError, '輸入資料有誤，比對 Excel 標頭與預期不同'
    end

    def validate_shop_names!(sheet)
      all_shop_names = sheet.column(1)[1..-1]
      raise ParseError, '無資料' if all_shop_names.blank?
      raise ParseError, '有重複的商家名稱，請檢查' if all_shop_names.uniq.size != all_shop_names.size

      existed_shop_names = Shop.where(name: all_shop_names).pluck(:name)
      return if existed_shop_names.blank?

      raise ParseError, "有 #{existed_shop_names.size} 筆已建立過: #{existed_shop_names.join(', ')}"
    end

    def process_shops(sheet)
      shops = []
      (2..sheet.last_row).each do |index|
        col_values = sheet_row(sheet, index)
        shop = Shop.new(col_values)
        shops << shop
      end
      Shop.import(shops)
    end

    def sheet_row(sheet, index)
      {
        name: sheet.row(index)[0],  # 商家名稱
        email: sheet.row(index)[1], # 信箱
        note: sheet.row(index)[2],  # 備註
      }
    end
  end
end
