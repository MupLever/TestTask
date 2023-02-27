# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PeriodChain do
  context 'test method valid?' do
    it 'has some behaviour' do
      period_chain = PeriodChain.new('16.07.2023', ["2023", "2024", "2025"])
      expect(period_chain.valid?).to eq(true)
    end

    it 'has some behaviour' do
      period_chain = PeriodChain.new('24.04.2023',	["2023", "2025", "2026"])
      expect(period_chain.valid?).to eq(false)
    end

		it 'has some behaviour' do
      period_chain = PeriodChain.new('31.01.2023', ["2023M1", "2023M2", "2023M3"])
      expect(period_chain.valid?).to eq(true)
    end
		it 'has some behaviour' do
			period_chain = PeriodChain.new('10.01.2023',	["2023M1", "2023M3", "2023M4"])
			expect(period_chain.valid?).to eq(false)
		end
	end
end
