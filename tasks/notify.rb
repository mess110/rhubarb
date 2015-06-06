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
  NotificationWrapper.send(client, user, msg, tldr)
end
