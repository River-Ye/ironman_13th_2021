# frozen_string_literal: true

class TestWorker
  include Sidekiq::Worker
  require 'sidekiq-limit_fetch'
  sidekiq_options retry: false, queue: 'test'

  def perform
    sleep 300
    logger.info "test"
    puts "test"
  end
end
