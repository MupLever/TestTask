# frozen_string_literal: true

require_relative 'main'
puts 'Input the start date'
start_date = gets.delete_suffix("\n")
puts 'Input count of periods'
count = gets.to_i
array_period = []
count.times do
  array_period << gets.delete_suffix("\n")
end

period_chain = PeriodChain.new(start_date, array_period)
while true
  puts 'Enter the command: \'add\' or \'valid?\''
  cmd = gets.delete_suffix("\n")
  case cmd
  when 'add'
    puts 'Enter the type of the new period: (\'daily\'/\'monthly\'/\'annually\')'
    new_period_type = gets.delete_suffix("\n")
    period_chain.add(new_period_type)
    puts period_chain.periods
  when 'valid?'
    puts period_chain.valid?
  else
    break
  end
end
