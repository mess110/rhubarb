require 'sendgrid-ruby'

class NotificationWrapper
  def self.client api_user=nil, api_key=nil
    SendGrid::Client.new do |c|
      c.api_user = api_user || ENV['SENDGRID_USERNAME']
      c.api_key = api_key || ENV['SENDGRID_PASSWORD']
    end
  end

  def self.send(client, user, msg, subject='Rhubarb Notification')
    puts "#{user['email']} has been notified"

    mail = SendGrid::Mail.new(to: user['email'],
                              from: 'no-reply@rhubarb.northpole.ro',
                              subject: subject, text: msg, html: msg)

    client.send(mail)
  end
end
