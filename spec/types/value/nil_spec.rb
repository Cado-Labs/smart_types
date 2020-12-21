# frozen_string_literal: true

RSpec.describe 'SmartCore::Types::Value::Nil' do
  shared_examples 'type operations' do
    specify 'type-casting' do
      expect { type.cast(Object.new) }.to raise_error(
        SmartCore::Types::TypeCastingUnsupportedError
      )

      expect { type.cast(BasicObject.new) }.to raise_error(
        SmartCore::Types::TypeCastingUnsupportedError
      )
    end

    specify 'type-checking' do
      expect(type.valid?(nil)).to eq(true)
      expect(type.valid?(Object.new)).to eq(false)
      expect(type.valid?(BasicObject.new)).to eq(false)
    end

    specify 'type-validation' do
      expect { type.validate!(nil) }.not_to raise_error
      expect { type.validate!(Object.new) }.to raise_error(SmartCore::Types::TypeError)
      expect { type.validate!(BasicObject.new) }.to raise_error(SmartCore::Types::TypeError)
    end
  end

  context 'non-nilable type' do
    let(:type) { SmartCore::Types::Value::Nil }

    include_examples 'type operations'
  end

  context 'runtime-based non-nilable type' do
    let(:type) { SmartCore::Types::Value::Nil() }

    include_examples 'type operations'
  end

  context 'nilable type' do
    let(:type) { SmartCore::Types::Value::Nil.nilable }

    include_examples 'type operations'
  end

  context 'runtime-based nilable type' do
    let(:type) { SmartCore::Types::Value::Nil().nilable }

    include_examples 'type operations'
  end

  specify 'has no support for runtime attributes' do
    expect { SmartCore::Types::Value::Nil(nil) }.to raise_error(
      SmartCore::Types::RuntimeAttriburtesUnsupportedError
    )
  end
end
