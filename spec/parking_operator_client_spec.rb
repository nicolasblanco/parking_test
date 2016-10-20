require 'parking_operator_client'

RSpec.describe ParkingOperatorClient do
  describe '#initialize' do
    it 'sends commands to the operator' do
      expect(ARGV).to receive(:any?).and_return(false)
      expect(Kernel).to receive(:loop).and_yield
      expect($stdin).to receive(:gets).and_return("my_command\n")
      expect_any_instance_of(ParkingOperator).to receive(:execute_command).with('my_command').and_return('OK')

      described_class.new
    end
  end
end
