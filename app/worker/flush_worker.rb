# frozen_string_literal: true

class FlushWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, batch_flush_size: 5, batch_flush_interval: 30, batch_unique: true

  def perform(groups = nil)
    puts "args: #{groups}"
    puts "execute #{self.class}"
  end
end
