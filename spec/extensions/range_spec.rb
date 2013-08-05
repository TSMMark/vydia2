require 'spec_helper'

describe Range do
  let (:min)    { (0..50).to_a.sample }
  let (:max)    { (50..100).to_a.sample }
  let (:range)  { (min..max) }
  subject       { range }

  context :sample do
    subject { range.sample }
    it      { should be_between( min, max ) }
  end

end
