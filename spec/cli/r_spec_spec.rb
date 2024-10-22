# frozen_string_literal: true

require 'rspec'

RSpec.describe 'RSpec' , type: :aruba do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'when condition' do
    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @ost.cmdline_0.make_cmdline_1(test_case_dir, @ost.result, option_extra.join(" "), file_list)
    end

    it 'succeeds' do
      cmdline = ""
      run_command("bash #{cmdline}")
    end
  end
end
