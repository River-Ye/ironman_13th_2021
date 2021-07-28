# frozen_string_literal: true

class TestWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'test'

  def perform
    logger.info "test"
    puts "test"
  end
end
