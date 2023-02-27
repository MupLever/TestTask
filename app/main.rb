# frozen_string_literal: true

require 'date'

class PeriodChain
  attr_reader :periods
  def initialize(start_date, periods)
    @start_date = Date.strptime(start_date, '%d.%m.%Y')
    @periods = periods
  end

  def add(_type)
    return unless valid?

    case _type
    when 'daily'
      @periods.append("#{@last_date.year}M#{@last_date.month}D#{@last_date.day}")
    when 'monthly'
      @periods.append("#{@last_date.year}M#{@last_date.month}")
    when 'annually'
      @periods.append(@last_date.year.to_s)
    end
  end

  def valid?
    @last_date = @start_date
    shift = @last_date.day
    @periods.each do |period|
      date = identify_to_date(period)
      if period.include?('D')
        return false unless date.eql?(@last_date)

        @last_date, shift = @last_date.next_day
        shift = @last_date.day

      elsif period.include?('M')
        return false unless [date.year, date.month].eql?([@last_date.year, @last_date.month])

        @last_date = @last_date.next_month
        mdays = count_days_in_month(@last_date.month, @last_date.year)
        @last_date = Date.new(@last_date.year, @last_date.month, shift) if shift <= mdays

      else
        return false unless date.year.eql?(@last_date.year)

        @last_date = @last_date.next_year
      end
      # p "#{@last_date}"
    end
    true
  end

  private

  def count_days_in_month(month, year)
    mdays = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    mdays[2] = 29 if Date.leap?(year)
    mdays[month]
  end

  def identify_to_date(period)
    return Date.new(*period.split(/[MD]/).map(&:to_i)) if period.match?(/[MD]/)

    Date.new(period.to_i)
  end
end
