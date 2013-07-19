require 'spec_helper'

describe Hash do
  describe 'fill_with(!)' do
    let (:original_hash)  { {somekey: :somevalue, anotherkey: :anothervalue, yetanother: :yetvalue} }
    let (:hash)           { original_hash.clone }
    let (:new_value)      { 'new value' }

    context 'no bang' do
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


    context 'bang!' do
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
end
