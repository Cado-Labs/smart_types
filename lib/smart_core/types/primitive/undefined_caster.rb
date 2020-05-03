# frozen_string_literal: true

# @api private
# @since 0.1.0
class SmartCore::Types::Primitive::UndefinedCaster < SmartCore::Types::Primitive::Caster
  # @param expression [NilClass, Any]
  # @return [void]
  #
  # @api private
  # @since 0.1.0
  def initialize(expression = nil)
    super
  end

  # @param value [Any]
  # @return [void]
  #
  # @raise [SmartCore::Types::TypeCastingUnsupportedError]
  #
  # @pai private
  # @since 0.1.0
  def call(value)
    raise(
      SmartCore::Types::TypeCastingUnsupportedError,
      'This type has no support for type casting'
    )
  end
end
