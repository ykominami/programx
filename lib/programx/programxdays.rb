# frozen_string_literal: true

module Programx
  class Programxdays < AbstProgramx
    attr_reader :today_pn, :today_str, :files

    def initialize
      home_dir = Dir.home
      @home_pn = Pathname.new(home_dir)
      @documents_pn = @home_pn + 'Documents'
      @days_pn = @documents_pn + 'DAYS'

      today = Date.today
      # today = Date.new(2023,5.16)
      @today_str = today.strftime('%Y%m%d')
      @today_pn = @days_pn + @today_str
      @today_pn.mkdir unless @today_pn.exist?
      @base = BaseProgramx.new
      @files = @base.files
      @today_pn.children.map do |pn|
        @files << BaseProgramx.get_basename(pn) if pn.file?
      end
      # p "@files=#{@files}"
    end

    def open_with_new_file(base_name: nil, ext: '.txt')
      base_name ||= @today_str
      file_pn = get_new_file_pn(@today_pn, base_name, ext: ext)
      File.write(file_pn, '')
      @base.open_with_new_file(file_pn)
      file_pn
    end
  end
end
