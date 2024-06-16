# frozen_string_literal: true

module Programx
  class Programxcur < BaseProgramx
    def initialize
      cur_dir = '.'
      @cur_pn = Pathname.new(cur_dir)

      super()
      @cur_pn.children.map do |pn|
        @files << BaseProgramx.get_basename(pn) if pn.file?
      end
      # p @files
    end

    def oepn_with_new_file(base_name: nil, ext: nil)
      base_name ||= 'a'
      file_pn = get_new_file_pn(@cur_pn, base_name, ext)
      super(file_pn)
      # puts "Programxcur#open_with_new_file file_pn=#{file_pn}"
      file_pn
    end

    def get_new_file_pn(dir_pn, base_name, ext = '.txt')
      pn = dir_pn + (base_name + ext)
      return pn unless pn.exist?

      n = 2
      pn = nil
      1.upto(10) do
        variable_part = "_#{n}"
        pn = get_new_file_pn_sub(dir_pn, base_name, variable_part: variable_part, ext: ext)
        break if pn

        n += 1
      end
      # File.write(pn, "")
      # p "PC2 Programxcur#get_new_file_pn pn=#{pn}"
      pn
    end
  end
end
