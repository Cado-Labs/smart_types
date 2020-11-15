# frozen_string_literal: true

# @api private
# @since 0.1.0
# @version 0.3.0
module SmartCore::Types::Primitive::MultFactory
  require_relative 'mult_factory/definition_context'

  class << self
    # @param types [Array<SmartCore::Types::Primtive>]
    # @param type_definition [NilClass, Proc]
    # @return [SmartCore::Types::Primitive]
    #
    # @api private
    # @since 0.1.0
    # @version 0.3.0
    def create_type(types, type_definition)
      type_definitions = build_type_definitions(type_definition)
      type_validator = build_type_validator(types, type_definitions)
      type_caster = build_type_caster(types, type_definitions)
      build_type(type_validator, type_caster).tap do |type|
        assign_type_validator(type, type_validator)
      end
    end

    private

    # @param type_definition [NilClass, Proc]
    # @return [SmartCore::Types::Primitive::MultFactory::DefinitionContext]
    #
    # @pai private
    # @since 0.1.0
    def build_type_definitions(type_definition)
      SmartCore::Types::Primitive::MultFactory::DefinitionContext.new.tap do |context|
        context.instance_eval(&type_definition) if type_definition
      end
    end

    # @param types [Array<SmartCore::Types::Primtive>]
    # @param type_definitions [SmartCore::Types::Primitive::MultFactory::DefinitionContext]
    # @return [SmartCore::Types::Primitive::MultValidator]
    #
    # @api private
    # @since 0.1.0
    def build_type_validator(types, type_definitions)
      SmartCore::Types::Primitive::MultValidator.new(*types.map(&:validator))
    end

    # @param types [Array<SmartCore::Types::Primtive>]
    # @param type_definition [SmartCore::Types::Primitive::MultFactory::DefinitionContext]
    # @return [SmartCore::Types::Primitive::Caster]
    #
    # @api private
    # @since 0.1.0
    def build_type_caster(types, type_definitions)
      if type_definitions.type_caster == nil
        SmartCore::Types::Primitive::UndefinedCaster.new
      else
        SmartCore::Types::Primitive::Caster.new(type_definitions.type_caster)
      end
    end

    # @param type [SmartCore::Types::Primitive]
    # @param type_validator [SmartCore::Types::Primitive::MultValidator]
    # @return [void]
    #
    # @api private
    # @since 0.3.0
    def assign_type_validator(type, type_validator)
      type_validator.___assign_type___(type)
    end

    # @param type_validator [SmartCore::Types::Primitive::MultValidator]
    # @param type_caster [SmartCore::Types::Primitive::Caster]
    # @return [SmartCore::Types::Primitive]
    #
    # @api private
    # @since 0.1.0
    # @version 0.3.0
    def build_type(type_validator, type_caster)
      SmartCore::Types::Primitive.new(type_validator, type_caster)
    end
  end
end
