require 'open3'

RSpec.describe 'integration' do
  let(:expected_output) do
    File.readlines(File.expand_path('./factories/commands_expected_output.txt', File.dirname(__FILE__)))
  end

  it 'reads the commands file and has correct output' do
    arg = File.expand_path('./factories/commands.txt', File.dirname(__FILE__))
    exe = File.expand_path('../bin/parking_client', File.dirname(__FILE__))

    stdin, stdout, stderr = Open3.popen3("#{exe} #{arg}")

    expect(stdout.readlines).to eq(expected_output)
  end
end
