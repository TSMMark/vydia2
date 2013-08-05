# attribute is not blank
RSpec::Matchers.define :have_value_in do |attribute_name|
  match do |object_with_attributes|
    object_with_attributes.respond_to?(attribute_name) &&
    object_with_attributes.send(attribute_name).blank? == false
  end
end