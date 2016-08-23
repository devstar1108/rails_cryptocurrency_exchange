module Worker
  class SmsNotification

    def process(payload, metadata, delivery_info)
      payload.symbolize_keys!

      @receiver_phone = Phonelib.parse(payload[:phone]).international
      if @receiver_phone.start_with?("+86")
        raise "CLICKATELL_NUMBER not set" if ENV['CLICKATELL_API_ID'].blank?

        clickatell_client.send_message(@receiver_phone, payload[:message])

      else
        raise "TWILIO_NUMBER not set" if ENV['TWILIO_NUMBER'].blank?

        twilio_client.account.sms.messages.create(
          from: ENV["TWILIO_NUMBER"],
          to:  @receiver_phone ,
          body: payload[:message]
        )
      end

    end


    def twilio_client
      Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"], ssl_verify_peer: false
    end

    def clickatell_client
      Clickatell::API.authenticate(ENV["CLICKATELL_API_ID"], ENV["CLICKATELL_USER_ID"], ENV["CLICKATELL_USER_PASSWORD"])
    end
  end
end
