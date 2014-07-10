require 'faker'
require 'digest'
require 'time'

NUM_URLS = 50
NUM_RECORDS = 1000000
count = 1
now = Time.new
start = now - (60*60*24*10)

urls = ["http://apple.com", "https://apple.com", "https://www.apple.com", "http://developer.apple.com", "http://en.wikipedia.org", "http://opensource.org"]
referrers = ["http://apple.com", "https://apple.com", "https://www.apple.com", "http://developer.apple.com", "NULL"]

def populateWithRandomUrls(arr)
  NUM_URLS.times do
    arr.push("http://" + Faker::Internet.domain_name())
  end
end

def randomDate(now, start)
  Time.at((now.to_f - start.to_f)*rand + start.to_f)
end

def createHash(record)
  Digest::MD5.hexdigest(record.to_s)
end

populateWithRandomUrls(urls)
populateWithRandomUrls(referrers)

NUM_RECORDS.times do
  record = {
    id: count,
    url: urls[rand(NUM_URLS)],
    referrer: referrers[rand(NUM_URLS)],
    created_at: randomDate(now, start)
  }
  record = record.except(:referrer) if record[:referrer] == "NULL"
  count += 1
  record[:hash] = createHash(record)
  PageView.insert(record.except(:id))
end
