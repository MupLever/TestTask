# frozen_string_literal: true

require 'date'

class PeriodChain
  def initialize(start_date, periods)
    @start_date = Date.strptime(start_date, '%d.%m.%Y')
    @periods = periods
  end

  def valid?
    temp = @start_date
    @periods.each_with_index do |period, index|
      if period.include?('D')
        array_date = period.split(/[MD]/).map(&:to_i)
        date = Date.new(*array_date)
        return false unless date.eql?(temp)

        temp = temp.next_day

      elsif period.include?('M')
        array_date = period.split('M').map(&:to_i)
        date = Date.new(*array_date)
        return false unless date.year == temp.year && date.month == temp.month

        temp = temp.next_month

      else
        date = Date.new(period.to_i)
        return false unless date.year == temp.year

        temp = temp.next_year

      end
      # p "[#{index}]: #{temp}"
    end
    true
  end
end

period_cahin = PeriodChain.new('30.01.2023', %w[2023M1D30 2023M1 2023M2 2023 2024M3 2024M4D30 2024M5])
p period_cahin.valid?
