# frozen_string_literal: true

# @api private
# @since 0.2.0
class SmartCore::Types::Primitive::MultValidator < SmartCore::Types::Primitive::SumValidator
  require_relative 'mult_validator/result'

  # @overload valudate(value)
  #   @param value [Any]
  #   @return [SmartCore::Types::Primitive::MultValidator::Result]
  #
  # @api private
  # @since 0.2.0

  private

  # @param validation [Block]
  # @yieldparam [void]
  # @yieldreturn [SmartCore::Engine::Atom]
  # @return [SmartCore::Types::Primitive::MultValidator::Result]
  #
  # @api private
  # @since 0.2.0
  def compile_validation_result(&validation)
    # NOTE: at this moment type sum does not support invariant checking
    # TODO (0.3.0):
    #   @yieldreturn [SmartCore::Types::Primitive::Validator::Result]
    #   => and:
    #   SmartCore::Types::Primitive::MultValidator::Result.new(
    #     type, final_result.value, final_result.value.invariant_errors
    #   )
    SmartCore::Types::Primitive::MultValidator::Result.new(type, yield.value)
  end
end
