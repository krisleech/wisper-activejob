RSpec.describe 'integration tests:' do
  let(:publisher) do
    Class.new do
      include Wisper::Publisher

      def run
        broadcast(:it_happened, 'hello, world')
      end
    end.new
  end

  let(:subscriber) do
    Class.new do
      def self.it_happened
        # noop
      end
    end
  end

  let(:adapter) { ActiveJob::Base.queue_adapter }

  before do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear
  end

  it 'puts job on ActiveJob queue' do
    publisher.subscribe(subscriber, async: Wisper::ActiveJobBroadcaster.new)

    publisher.run

    expect(adapter.enqueued_jobs.size).to eq 1
  end
end
