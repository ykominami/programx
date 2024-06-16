# frozen_string_literal: true

require 'programx'
require 'pathname'
require 'date'
require 'glimmer-dsl-libui'


class Programxgui
  include Glimmer

  def initialize
    setup
  end

  def start
    @window.show
  end

  def setup
    @days_data = []
    @cur_data = []
    @procur = Programx::Programxcur.new
    @prodays = Programx::Programxdays.new
    @prodays.files.map(&:to_s).each do |fpath|
      @days_data << [fpath]
    end
    # p "@days_data=#{@days_data}"
    @procur.files.map(&:to_s).each do |fpath|
      @cur_data << [fpath]
    end

    @window = window('File', 600, 600) do
      margined false
      vertical_box do
        form do
          stretchy false
          @name_entry = entry do
            label 'DaysDir'
          end
          @name_entry.text = @prodays.today_pn.to_s
        end
        horizontal_box do
          stretchy false
          button('New cur') do
            stretchy false
            on_clicked do
              new_file = @procur.oepn_with_new_file
              data << new_file.to_s
            end
          end
          button('Open cur') do
            stretchy false
            on_clicked do
              new_file = @procur.oepn_with_new_file
              data << new_file.to_s
            end
          end
          button('New days') do
            stretchy false
            on_clicked do
              new_file = @prodays.open_with_new_file
              @days_data << new_file.to_s
            end
          end
          button('Exit') do
            stretchy false
            on_clicked do
              LibUI.quit
            end
          end
        end
        @vbox1 = vertical_box do
          stretchy true
          @vbox11 = vertical_box do
            stretchy false
            label 'Days'
          end
          horizontal_box do
            @days_table = table do
              text_column('File')
              editable true
              cell_rows @days_data
              on_changed do |row, type, row_data|
                # puts "Row #{row} #{type}: #{row_data}"
                # $stdout.flush # for Windows
              end
              on_edited do |row, row_data|
                puts "Row #{row} edited: #{row_data}"
                # $stdout.flush # for Windows
              end
            end
            non_wrapping_multiline_entry
          end
        end
        @vbox2 = vertical_box do
          stretchy true
          @vbox21 = vertical_box do
            stretchy false
            label 'Cur'
          end
          horizontal_box do
            @cur_tabe = table do
              text_column('File')
              editable true
              cell_rows @cur_data
              on_changed do |row, type, row_data|
                # puts "Row #{row} #{type}: #{row_data}"
                # $stdout.flush # for Windows
              end
              on_edited do |row, row_data|
                puts "Row #{row} edited: #{row_data}"
                # $stdout.flush # for Windows
              end
            end
            non_wrapping_multiline_entry
          end
        end
      end
    end
  end
end

Programxgui.new.start
