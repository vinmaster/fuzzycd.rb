require 'spec_helper'

RSpec.describe Fuzzycd::Cli do
  TEST_DIRECTORY = 'spec/test_directory'.freeze

  subject { capture_stdout { described_class.new(*args).run } }

  describe '#run' do
    context 'with --list flag' do

      let(:entries) { Fuzzycd::Command.list_directory(TEST_DIRECTORY).join("\n").to_s + "\n" }
      let(:args) { ['--list', TEST_DIRECTORY] }

      it 'should list files and directories' do
        is_expected.to eql(entries)
      end
    end
  end

end
