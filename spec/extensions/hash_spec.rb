require 'spec_helper'

describe Hash do
  let (:original_hash)  { {somekey: :somevalue, anotherkey: :anothervalue, yetanother: :yetvalue} }
  let (:hash)           { original_hash.clone }

  describe 'fill_with(!)' do
    let (:new_value)      { 'new value' }

    describe 'no bang' do
      let (:new_hash) { hash.fill_with(new_value, keys) }

      context 'when no keys specified' do
        let (:keys)     { nil }
        it 'replaces values with new value' do
          new_hash.each do |k,val|
            val.should  == new_value
          end
        end
        it 'leaves original hash' do
          hash.should_not     == new_hash
        end
      end
      context 'when an array of keys specified' do
        let (:keys)     { [:somekey, :yetanother] }
        # let (:new_hash) { hash.fill_with(new_value, keys) }
        it 'replaces values with new value' do
          new_hash.each do |key,val|
            if keys.include? key
              val.should      == new_value
            else
              val.should_not  == new_value
            end
          end
        end
        it 'leaves original hash' do
          hash.should_not     == new_hash
        end
      end
      context 'when one key specified' do
        let (:keys)     { :somekey }
        # let (:new_hash) { hash.fill_with(new_value, keys) }
        it 'replaces values with new value' do
          new_hash.each do |key,val|
            if key == keys
              val.should      == new_value
            else
              val.should_not  == new_value
            end
          end
        end
        it 'leaves original hash' do
          hash.should_not     == new_hash
        end
      end
    end


    describe 'bang!' do
      let (:new_hash) { hash.fill_with!(new_value, keys) }

      context 'when no keys specified' do
        let (:keys)     { nil }
        it 'replaces values with new value' do
          new_hash.each do |k,val|
            val.should  == new_value
          end
        end
        it 'alters original hash' do
          hash.should     == new_hash
        end
      end
      context 'when an array of keys specified' do
        let (:keys)     { [:somekey, :yetanother] }
        it 'replaces values with new value' do
          new_hash.each do |key,val|
            if keys.include? key
              val.should      == new_value
            else
              val.should_not  == new_value
            end
          end
        end
        it 'alters original hash' do
          hash.should     == new_hash
        end
      end
      context 'when one key specified' do
        let (:keys)     { :somekey }
        it 'replaces values with new value' do
          new_hash.each do |key,val|
            if key == keys
              val.should      == new_value
            else
              val.should_not  == new_value
            end
          end
        end
        it 'alters original hash' do
          hash.should     == new_hash
        end
      end
    end
  end
  # .. fill_with(!)

  describe 'delete_keys(!)' do

    describe 'no bang' do
      let (:new_hash)   { hash.delete_keys(keys) }

      context 'when an array of keys' do
        let (:keys)       { [:somekey, :yetanother] }

        it 'previously contained the keys' do
          keys.each do |k|
            hash.should be_include(k)
          end
        end
        it 'removes keys from hash' do
          new_hash.should have_at_least(1).items
          new_hash.each do |k,v|
            keys.include?(k).should be_false
          end
        end
        it 'leaves original hash' do
          new_hash.should_not   == hash
        end
      end

      context 'when singular key' do
        let (:keys)       { :somekey }

        it 'previously contained the key' do
          hash.should be_include(keys)
        end
        it 'removes key from hash' do
          new_hash.should have_at_least(1).items
          new_hash.each do |k,v|
            k.should_not  == keys
          end
        end
        it 'leaves original hash' do
          new_hash.should_not   == hash
        end
      end

    end

    describe 'bang!' do
      let (:new_hash)   { hash.delete_keys!(keys) }

      context 'when an array of keys' do
        let (:keys)       { [:somekey, :yetanother] }

        it 'previously contained the keys' do
          keys.each do |k|
            hash.should be_include(k)
          end
        end
        it 'removes keys from hash' do
          new_hash.should have_at_least(1).items
          new_hash.each do |k,v|
            keys.include?(k).should be_false
          end
        end
        it 'leaves original hash' do
          new_hash.should   == hash
        end
      end

      context 'when singular key' do
        let (:keys)       { :somekey }

        it 'previously contained the key' do
          hash.should be_include(keys)
        end
        it 'removes key from hash' do
          new_hash.should have_at_least(1).items
          new_hash.each do |k,v|
            k.should_not  == keys
          end
        end
        it 'leaves original hash' do
          new_hash.should   == hash
        end
      end

    end

  end
  # .. delete_keys(!)

end
