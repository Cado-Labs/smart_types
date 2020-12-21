# frozen_string_literal: true

RSpec.describe 'SmartCore::Types::Value::Array' do
  shared_examples 'type casting' do
    specify 'type-casting' do
      expect(type.cast(123)).to eq([123])
      expect(type.cast('test')).to eq(['test'])
      expect(type.cast(:test)).to eq([:test])
      expect(type.cast([])).to eq([])
      expect(type.cast([123, '456', :test])).to eq([123, '456', :test])
      expect(type.cast({})).to eq([])
      expect(type.cast({ a: 1, b: '2', 'c' => :test })).to eq([[:a, 1], [:b, '2'], ['c', :test]])
      expect(type.cast(nil)).to eq([])

      as_array_1 = Class.new { def to_a; [123]; end }.new
      as_array_2 = Class.new { def to_ary; ['456']; end }.new
      non_array_1 = Class.new { def to_a; :test; end }.new
      non_array_2 = Class.new { def to_ary; 'test'; end }.new
      basic_object = BasicObject.new

      expect(type.cast(as_array_1)).to eq([123])
      expect(type.cast(as_array_2)).to eq(['456'])
      expect(type.cast(non_array_1)).to eq([non_array_1])
      expect(type.cast(non_array_2)).to eq([non_array_2])
      expect(type.cast(basic_object)).to eq([basic_object])
    end
  end

  shared_examples 'type-checking / type-validation (non-nilable)' do
    specify 'type-checking' do
      expect(type.valid?([])).to eq(true)
      expect(type.valid?([123, '456', :test])).to eq(true)
      expect(type.valid?(123)).to eq(false)
      expect(type.valid?(Object.new)).to eq(false)
      expect(type.valid?(BasicObject.new)).to eq(false)
      expect(type.valid?(nil)).to eq(false)
    end

    specify 'type-validation' do
      expect { type.validate!([]) }.not_to raise_error
      expect { type.validate!([123, '456', :test]) }.not_to raise_error
      expect { type.validate!(123) }.to raise_error(SmartCore::Types::TypeError)
      expect { type.validate!(BasicObject.new) }.to raise_error(SmartCore::Types::TypeError)
      expect { type.validate!(nil) }.to raise_error(SmartCore::Types::TypeError)
    end
  end

  shared_examples 'type-checking / type-validation (nilable)' do
    specify 'type-checking' do
      expect(type.valid?([])).to eq(true)
      expect(type.valid?([123, '456', :test])).to eq(true)
      expect(type.valid?(123)).to eq(false)
      expect(type.valid?(Object.new)).to eq(false)
      expect(type.valid?(BasicObject.new)).to eq(false)
      expect(type.valid?(nil)).to eq(true) # NOTE: nil
    end

    specify 'type-validation' do
      expect { type.validate!([]) }.not_to raise_error
      expect { type.validate!([123, '456', :test]) }.not_to raise_error
      expect { type.validate!(nil) }.not_to raise_error
      expect { type.validate!(123) }.to raise_error(SmartCore::Types::TypeError)
      expect { type.validate!(BasicObject.new) }.to raise_error(SmartCore::Types::TypeError)
      expect { type.validate!(Object.new) }.to raise_error(SmartCore::Types::TypeError)
    end
  end

  context 'runtime-based non-nilable type' do
    let(:type) { SmartCore::Types::Value::Array() }

    include_examples 'type casting'
    include_examples 'type-checking / type-validation (non-nilable)'
  end

  context 'non-nilable type' do
    let(:type) { SmartCore::Types::Value::Array }

    include_examples 'type casting'
    include_examples 'type-checking / type-validation (non-nilable)'
  end

  context 'runtime-based nilable type' do
    let(:type) { SmartCore::Types::Value::Array().nilable }

    include_examples 'type casting'
    include_examples 'type-checking / type-validation (nilable)'
  end

  context 'nilable type' do
    let(:type) { SmartCore::Types::Value::Array.nilable }

    include_examples 'type casting'
    include_examples 'type-checking / type-validation (nilable)'
  end

  specify 'has no support for runtime attributes' do
    expect { SmartCore::Types::Value::Array(1) }.to raise_error(
      SmartCore::Types::RuntimeAttriburtesUnsupportedError
    )
  end
end
