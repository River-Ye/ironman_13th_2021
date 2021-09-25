# frozen_string_literal: true

class ProcessingPdf
  # ghostscript Documentation: https://www.ghostscript.com/doc/current/Use.htm

  def self.encryption(pwd, input_file, output_file)
    _stdout_str, _stderr_str, _status = Open3.capture3("gs -sDEVICE=pdfwrite -dBATCH -dNOPAUSE -dNOPROMPT -dQUIET \
                                                        -sOwnerPassword=#{pwd} -sUserPassword=manan \
                                                        -sOutputFile=#{output_file} #{input_file}")

    { success: true, msg: 'PDF加密完成' }
  end

  def self.decrypt(pwd, input_file, output_file)
    _stdout_str, stderr_str, _status = Open3.capture3("gs -q -sDEVICE=pdfwrite -dBATCH -dNOPAUSE \
                                                       -SPDFPassword=#{pwd} -sOutputFile=#{output_file} \
                                                       -c 30000000 setvmthreshold -f #{input_file}")

    return { error_msgs: stderr_str.remove("\n") } if stderr_str.present?

    { success: true, msg: 'PDF解密完成' }
  end
end
