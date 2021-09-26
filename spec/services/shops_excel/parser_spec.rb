# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShopsExcel::Parser do
  describe 'execute' do
    let(:excel_file) { Tempfile.new(%w[shops_import .xlsx]) }
    let(:excel) do
      file = excel_file
      file.binmode

      xlsx = Axlsx::Package.new
      workbook = xlsx.workbook
      workbook.add_worksheet(name: '商家清單') do |sheet|
        sheet.add_row(excel_titles)
        sheet.add_row(content_array1)
        sheet.add_row(content_array2)
      end
      xlsx.use_shared_strings = true
      xlsx.serialize(file)

      file.rewind
      file
    end
    let(:excel_titles) { ShopsExcel::Generator::TITLES }
    let(:content_array1) { ['shop_name_1', 'river@riverye.com', 'hello'] }
    let(:content_array2) { ['shop_name_2', 'test@riverye.com',  'world'] }

    subject { described_class.new.execute(excel) }

    context 'create shops successfully' do
      it 'data correctly' do
        expect { subject }.to change { Shop.count }.by(2)
        [content_array1, content_array2].each do |content_array|
          shop1 = Shop.find_by(name: content_array[0])
          expect(shop1).to have_attributes(
            name: content_array[0],
            email: content_array[1],
            note: content_array[2],
          )
        end
      end
    end

    context 'when return error' do
      let(:logger) { double }

      before do
        allow(Rails).to receive(:logger).and_return(logger)
      end

      def expect_error_message(error_message)
        expect(logger).to receive(:error).with(/\[ShopsExcel::Parser Error\] #{error_message}/)
        expect { subject }.to change { Shop.count }.by(0)
      end

      context 'when title is empty' do
        let(:excel_titles) { [nil, nil, nil] }
        let(:error_message) { '輸入資料有誤，比對 Excel 標頭與預期不同' }

        it { expect_error_message(error_message) }
      end

      context 'when data is empty' do
        let(:content_array1) { [nil, nil, nil] }
        let(:content_array2) { content_array1 }
        let(:error_message) { '無資料' }

        it { expect_error_message(error_message) }
      end

      context 'when data is duplicate' do
        let(:content_array2) { content_array1 }
        let(:error_message) { '有重複的商家名稱，請檢查' }

        it { expect_error_message(error_message) }
      end

      context 'when shop exists' do
        let(:shop) { create(:shop) }
        let(:content_array1) { [shop.name, shop.email, shop.note] }
        let(:content_array2) { ['shop_name_2', 'test@riverye.com', 'world'] }
        let(:error_message) { "有 1 筆已建立過: #{shop.name}" }

        it { expect_error_message(error_message) }
      end
    end
  end
end
