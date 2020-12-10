require 'nuntium'

class Sms::Nuntium
  attr_accessor :nuntium

  def self.instance
    @@instance ||= Sms::Nuntium.new
  end

  def send tester
    begin
      nuntium.send_ao tester.to_nuntium_params
    rescue Nuntium::Exception => e
      Sidekiq.logger.info e.message
    rescue StandardError => e
      Sidekiq.logger.info e.message
    end
  end

  def nuntium
    @nuntium ||= ::Nuntium.new(ENV['NUNTIUM_HOST'], ENV['NUNTIUM_ACCOUNT'], ENV['NUNTIUM_APP'], ENV['NUNTIUM_APP_PWD'])
  end
end
