class SmsJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 5

  def perform(tester)
    Sms::Nuntium.instance.send(tester)
  end
end
