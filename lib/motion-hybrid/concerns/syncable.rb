module MotionHybrid
  module Syncable
    extend MotionSupport::Concern

    module ClassMethods
      def sync_sessions(&block)
        BW::HTTP.get(root_url) do
          block.call
        end
      end
    end

  end
end
