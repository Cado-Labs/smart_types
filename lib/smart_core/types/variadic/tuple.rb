# frozen_string_literal: true

using SmartCore::Ext::BasicObjectAsObject

# @api public
# @since 0.3.0
SmartCore::Types::Variadic.define_type(:Tuple) do |type|
  type.runtime_attributes_checker do |runtime_attrs|
    runtime_attrs.any? && runtime_attrs.all? do |runtime_attr|
      runtime_attr.is_a?(::Class)
    end
  end

  type.define_checker do |value, tuple_signature|
    next false unless SmartCore::Types::Value::Array.valid?(value)
    next false if value.size != tuple_signature.size

    value.each_with_index.all? do |tuple_val, tuple_val_index|
      expected_tuple_type = tuple_signature.at(tuple_val_index)
      tuple_val.is_a?(expected_tuple_type)
    end
  end
end
