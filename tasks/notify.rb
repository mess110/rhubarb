client = NotificationWrapper.client

whats_good = Rhubarb.whats_good

msg = Rhubarb.format(whats_good)
tldr = Rhubarb.tldr(whats_good)

if msg.empty?
  puts 'Nothing in season.'
  exit 0
else
  puts "Message:\n#{msg}"
end

RhubarbUser.find.each do |user|
  tmp_msg = Rhubarb.random_greeting +
    "\n\nFood reminder:\n\n" +
    msg + "\n" + '-' * 80 +
    "\n\nTo unsubscribe visit\nhttp://rhubarb.northpole.ro/#/unsubscribe/#{user['id'].to_s}"
  NotificationWrapper.send(client, user, tmp_msg, tldr)
end
