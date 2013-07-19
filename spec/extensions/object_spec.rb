require 'spec_helper'

describe Object do
  describe 'make_array' do
    context 'on a string' do
      let (:string) { 'some string' }
      it 'returns an array with the string in it' do
        string.make_array.should == [string]
      end
    end
    context 'on an array' do
      let (:array)  { ['slot 1', 'slot 2'] }
      it 'returns the same array' do
        array.make_array.should == array
      end
    end
  end
end
