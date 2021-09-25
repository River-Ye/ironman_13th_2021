# frozen_string_literal: true

module Pdf
  class AddWatermarkPdf

    # input_file = Rails.root.join('data/river_demo_watermark.pdf')
    # output_file = input_file.dirname.join('done.pdf')
    # watermark_texts = %w[river_1 river_2 river_3]
    def execute(input_file, output_file, watermark_texts = [])
      tmp_watermark_file(input_file)              # 暫存的浮水印 PDF path
      generate_watermark_content(watermark_texts) # 產浮水印的 PDF
      combine_pdf(input_file, output_file)        # 將 input_file 與浮水印 PDF 合併
      FileUtils.rm_rf(@tmp_watermark_file)        # 移除暫存的浮水印 PDF
    end

    private

    def tmp_watermark_file(input_file)
      @tmp_watermark_file ||= input_file.dirname.join('tmp_watermark.pdf')
    end

    # 可自行設定字型大小、顏色等
    # Prawn Documentation: https://prawnpdf.org/api-docs
    # Prawn example: https://prawnpdf.org/manual.pdf
    def generate_watermark_content(watermark_texts)
      position, amount_per_page = watermark_args
      Prawn::Document.generate(@tmp_watermark_file) do
        watermark_texts.each_with_index do |watermark_text, index|
          page = index / amount_per_page + 1
          coordinate = position[index % amount_per_page]
          start_new_page if page != 1 && (index % amount_per_page).zero?
          go_to_page(page)
          float do
            bounding_box(coordinate, height: 14, width: 48) do
              fill_color '000000'
              fill_rectangle [0, bounds.height], bounds.width, bounds.height
              stroke_bounds
              fill_color 'FFFFFF'
              text watermark_text.to_s, align: :center, valign: :center, size: 12
            end
          end
        end
      end
    end

    # 浮水印在頁面上的位置、每頁的數量
    def watermark_args
      position = [[0, 769], [0, 392]] # xy 軸座標 (需自行計算適合的位置)
      amount_per_page = 2             # 每頁的浮水印數量

      [position, amount_per_page]
    end

    def combine_pdf(input_file, output_file)
      pdf_pages = CombinePDF.load(@tmp_watermark_file).pages
      pdf = CombinePDF.load(input_file)
      pdf.pages.each_with_index { |page, index| page << pdf_pages[index] }
      pdf.save(output_file)
    end
  end
end
