# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PeriodChain do
  context '#valid?' do
    example 'Example 1' do
      period_chain = PeriodChain.new('16.07.2023', %w[2023 2024 2025])
      expect(period_chain.valid?).to eq(true)
    end

    example 'Example 2' do
      period_chain = PeriodChain.new('24.04.2023',	%w[2023 2025 2026])
      expect(period_chain.valid?).to eq(false)
    end

    example 'Example 3' do
      period_chain = PeriodChain.new('31.01.2023', %w[2023M1 2023M2 2023M3])
      expect(period_chain.valid?).to eq(true)
    end

    example 'Example 4' do
      period_chain = PeriodChain.new('10.01.2023', %w[2023M1 2023M3 2023M4])
      expect(period_chain.valid?).to eq(false)
    end

    example 'Example 5' do
      period_chain = PeriodChain.new('04.06.1976', %w[1976M6D4 1976M6D5 1976M6D6])
      expect(period_chain.valid?).to eq(true)
    end

    example 'Example 6' do
      period_chain = PeriodChain.new('02.05.2023', %w[2023M5D2 2023M5D3 2023M5D5])
      expect(period_chain.valid?).to eq(false)
    end

    example 'Example 7' do
      period_chain = PeriodChain.new('30.01.2023', %w[2023M1 2023M2 2023M3D30])
      expect(period_chain.valid?).to eq(true)
    end

    example 'Example 8' do
      period_chain = PeriodChain.new('31.01.2023', %w[2023M1 2023M2 2023M3D30])
      expect(period_chain.valid?).to eq(false)
    end

    example 'Example 9' do
      period_chain = PeriodChain.new('30.01.2020', %w[2020M1 2020 2021 2022 2023 2024M2 2024M3D30])
      expect(period_chain.valid?).to eq(true)
    end

    example 'Example 10' do
      period_chain = PeriodChain.new('30.01.2020', %w[2020M1 2020 2021 2022 2023 2024M2 2024M3D29])
      expect(period_chain.valid?).to eq(false)
    end

    example 'Example 11' do
      period_chain = PeriodChain.new('30.01.2023',
                                     %w[2023M1D30 2023M1 2023M2 2023 2024M3 2024M4D30 2024M5])
      expect(period_chain.valid?).to eq(true)
    end
  end
end
