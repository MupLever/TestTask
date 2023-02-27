# frozen_string_literal: true

require 'date'

class PeriodChain
  def initialize(start_date, periods)
    @start_date = Date.strptime(start_date, '%d.%m.%Y')
    @periods = periods
  end

  def add(type)
    last_period = @periods.last
  end

  private def count_days_in_month(month, year)
    mdays = [nil,31,28,31,30,31,30,31,31,30,31.30,31]
    mdays[2] = 29 if Date.leap?(year)
    mdays[month]
  end

  def valid?
    temp_date = @start_date
    shift = temp_date.day
    @periods.each_with_index do |period, index|
      if period.include?('D')
        date = Date.new(*period.split(/[MD]/).map(&:to_i))
        return false unless date.eql?(temp_date)

        temp_date, shift = temp_date.next_day
        shift = temp_date.day

      elsif period.include?('M')
        date = Date.new(*period.split('M').map(&:to_i))
        return false unless date.year == temp_date.year && date.month == temp_date.month

        temp_date = temp_date.next_month
        mdays = count_days_in_month(temp_date.month, temp_date.year)
        temp_date = Date.new(temp_date.year, temp_date.month, shift) if shift <= mdays

      else
        date = Date.new(period.to_i)
        return false unless date.year == temp_date.year

        temp_date = temp_date.next_year

      end
      # p "[#{index}]: #{temp_date}"
    end
    true
  end
end

period_chain = PeriodChain.new('30.01.2023', ["2023M1D30", "2023M1", "2023M2", "2023", "2024M3", "2024M4D30", "2024M5"])
p period_chain.valid?
