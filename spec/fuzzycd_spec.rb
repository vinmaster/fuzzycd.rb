require 'spec_helper'

RSpec.describe Fuzzycd do
  subject { described_class }

  context 'version' do
    it 'should have version number' do
      expect(subject::VERSION).not_to be_nil
    end
  end
end
