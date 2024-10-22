# frozen_string_literal: true

module Programx
  class BaseProgramx < AbstProgramx
    attr_reader :files

    def self.get_basename(pathn)
      pathn.expand_path.basename.to_s
    end

    def initialize
      @prog_path = %s(start)
      @files = []
    end

    def open_with_new_file(file_pn)
      system(@prog_path.to_s, file_pn.to_s)
    end

    def get_new_file_pn_sub(dir_pn, base_name, variable_part: '', ext: '.txt')
      pn = dir_pn + (base_name + variable_part + ext)
      pn.exist? ? pn : nil
    end

    def get_new_file_pn(dir_pn, base_name, ext: '.txt')
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
      pn
    end
  end
end
