RSpec.describe Wisper::ActiveJob::Listener do
  it 'prevents Wisper::ActiveJob::Listener being included without ActiveJob in context' do
    expect {
      Class.new do
        include Wisper::ActiveJob::Listener
      end
    }.to raise_error(RuntimeError, /ensure your class has ActiveJob::Base in its ancestry/)
  end

  let(:listener) {
    Class.new(::ActiveJob::Base) do
      include Wisper::ActiveJob::Listener

      def self.my_event(arg1, arg2)
        [arg1, arg2]
      end
    end
  }

  it 'defines a #perform method that calls the expected class methods with arguments splatted' do
    expect(listener.new.perform("my_event", [1, 2])).to eq([1, 2])
    expect(listener.new.perform(:my_event, [1, 2])).to eq([1, 2])
  end
end
