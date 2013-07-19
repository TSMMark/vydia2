require 'spec_helper'

describe String do

  describe 'numeric?' do
    it { '584305'.should      be_numeric }
    it { '000000'.should      be_numeric }
    it { '4092t4'.should_not  be_numeric }
    it { 'sadior'.should_not  be_numeric }
    it { 'CaPiTs'.should_not  be_numeric }
    it { ''.should_not        be_numeric }
    it { '58490 '.should_not  be_numeric }
    it { ' 58490'.should_not  be_numeric }
  end

  describe 'positive_integer?' do
    it { '99'.should      be_positive_integer }
    it { '-9'.should_not  be_positive_integer }
    it { '00'.should_not  be_positive_integer }
  end

  describe 'nonnegative_integer?' do
    it { '99'.should      be_nonnegative_integer }
    it { '-9'.should_not  be_nonnegative_integer }
    it { '00'.should      be_nonnegative_integer }
  end

  describe 'cgi_escape(!)' do
    let (:s)          { 'initial&string' }
    let (:s_escaped)  { 'initial%26string' }

    context 'no bang!' do
      it 'escapes string' do
        s.cgi_escape.should == s_escaped
      end
      it 'leaves original string' do
        s.cgi_escape
        s.should_not == s_escaped
      end
    end

    context 'with bang!' do
      it 'escapes string' do
        s.cgi_escape!.should == s_escaped
      end
      it 'alters original string' do
        s.cgi_escape!
        s.should == s_escaped
      end
    end

    context '_replace_all!' do
      let (:replace_to) { 'replaced string' }
      it 'replaces string' do
        s._replace_all!(replace_to).should == replace_to
      end
      it 'alters original string' do
        s._replace_all!(replace_to)
        s.should == replace_to
      end
    end

  end

end
