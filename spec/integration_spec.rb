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

  let(:subscriber_with_queue) do
    Class.new do
      def self.queue
        :fast
      end

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
    publisher.subscribe(subscriber_with_queue, async: Wisper::ActiveJobBroadcaster.new)

    publisher.run

    expect(adapter.enqueued_jobs.size).to eq 2
    expect(adapter.enqueued_jobs.map { |job| job[:queue] }).to match_array ["default", "fast"]
  end
end
