class Tester < ApplicationRecord
  belongs_to :broadcast

  after_commit :enqueue_sms

  def to_nuntium_params
    raise Nuntium::Exception.new('Missing recipient') unless phone_number.present?

    tel = Tel.new phone_number

    raise Nuntium::Exception.new('Unknown channel exception') if tel.carrier.nil? 

    {
      from: ENV['NUNTIUM_APP'],
      to: "sms://#{tel.with_country_code}",
      body: body_message,
      suggested_channel: tel.carrier
    }
  end

  private

  def enqueue_sms
    SmsJob.perform_later self
  end

  def body_message
    st = ''

    st += "អាយុ #{age} ឆ្នាំ " if age.present?
    st += "ភេទ #{gender} " if gender.present?
    st += "លេខកូដធ្វើតេស្ត #{lab_code}" if lab_code.present?

    st
  end
end
