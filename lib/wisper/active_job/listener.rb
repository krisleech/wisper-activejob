module Wisper
  module ActiveJob
    # Helper class to allow an ActiveJob to be its own asynchronous listener without Wisper's
    # Wisper::ActiveJobBroadcaster::Wrapper being needed
    module Listener
      def self.included(base)
        return if base < ::ActiveJob::Base
        raise("Wisper::ActiveJob::Listener has been included in a class which does not extend from ActiveJob::Base. " \
          "Please ensure your class has ActiveJob::Base in its ancestry (either directly or via e.g. ApplicationJob)")
      end

      def perform(event_name, args)
        self.class.public_send(event_name, *args)
      end
    end
  end
end
