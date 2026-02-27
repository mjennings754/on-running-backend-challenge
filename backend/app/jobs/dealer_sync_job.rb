class DealerSyncJob < ApplicationJob
    queue_as :default

    def perform
        DealerSyncService.call
    end
end
