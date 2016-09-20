require 'parking_operator'

class ParkingOperatorClient
  def initialize
    parking_operator = ParkingOperator.new

    if ARGV.any?
      ARGF.each_line do |command|
        command.strip!
        puts parking_operator.execute_command(command) unless command.empty?
      end
      return
    end

    puts 'Parking Operator Reader and awaiting commands...'
    Kernel.loop do
      command = $stdin.gets.chomp
      begin
        puts parking_operator.execute_command(command)
      rescue ParkingOperator::InvalidCommand
        puts 'Invalid command'
      end
    end
  end
end
