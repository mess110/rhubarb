require 'date'

class Date
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def self.days_in_month(month, year = Time.now.year)
    return 29 if month == 2 && Date.gregorian_leap?(year)
    COMMON_YEAR_DAYS_IN_MONTH[month]
  end
end

class Time
  def self.nowify(date_s)
    parse(date_s).change(year: Time.now.year)
  end

  def change(hash = {})
    Time.mktime(hash[:year] || self.year, hash[:month] || self.month,
                hash[:day] || self.day, hash[:hour] || self.hour,
                hash[:min] || self.min, 0, 0)
  end

  def pretify
    half = Date.days_in_month(Time.now.month) / 2
    if (self.day > half - 4) && (half + 4 > self.day)
      self.strftime("middle of %B")
    elsif self.day < half
      self.strftime("beginning of %B")
    else
      self.strftime("end of %B")
    end
  end
end

class String
  def nowify
    Time.nowify(self)
  end
end

class Hash
  def to_rhubarb
    "#{self[:title]}: #{self[:start_date].nowify.pretify} -> #{self[:end_date].nowify.pretify}"
  end
end

class Rhubarb

  REQUIRED_KEYS = %w(title start_date end_date)
  GREETINGS = %w(Aloha Ahoy Bonjour G'day Hello Hallo Hey Hi Hola Howdy Rawr Salutations Salut Sup Yo)

  def self.random_greeting
    GREETINGS.sample
  end

  # Finds what is good on a specific date
  def self.whats_good(date = Time.now)
    all.select do |e|
      start_date = e[:start_date].nowify
      end_date = e[:end_date].nowify
      start_date < date && date < end_date
    end
  end

  # Responsible for formatting what is in the current season
  def self.format(array)
    validate_array(array)
    s = ""
    array.each do |e|
      s += "#{e.to_rhubarb}\n"
    end
    s
  end

  def self.tldr(array)
    validate_array(array)
    "TLDR: #{array.collect{|e| e[:title]}.join(', ')}"
  end

  def self.all
    [
      {
        title: 'rhubarb',
        start_date: '2001-04-01',
        end_date: '2001-06-30',
        img: {
          src: 'https://stocksnap.io/photo/YOU6942709',
          direct: 'https://snap-photos.s3.amazonaws.com/img-thumbs/960w/YOU6942709.jpg'
        }
      },
      {
        title: 'nettle', # urzică
        start_date: '2001-03-01',
        end_date: '2001-05-31',
      },
      {
        title: 'parsley', # pătrunjel
        start_date: '2001-03-01',
        end_date: '2001-09-15',
      },
      {
        title: 'lovage', # leuștean
        start_date: '2001-03-01',
        end_date: '2001-05-31',
      },
      {
        title: 'wild garlic', # leurdă
        start_date: '2001-03-01',
        end_date: '2001-05-31',
      },
      {
        title: 'green salad', # salată verde
        start_date: '2001-03-01',
        end_date: '2001-06-15',
      },
      {
        title: 'green onion', # ceapă verde
        start_date: '2001-03-01',
        end_date: '2001-06-15',
      },
      {
        title: 'garlic',
        start_date: '2001-03-01',
        end_date: '2001-06-15',
      },
      {
        title: 'spinach',
        start_date: '2001-03-01',
        end_date: '2001-05-31',
      },
      {
        title: 'rucola',
        start_date: '2001-03-01',
        end_date: '2001-05-31',
      },
      {
        title: 'dill',
        start_date: '2001-03-01',
        end_date: '2001-05-31',
      },
      {
        title: 'mint',
        start_date: '2001-04-01',
        end_date: '2001-09-15',
      },
      {
        title: 'rosemary',
        start_date: '2001-05-01',
        end_date: '2001-05-31',
      },
      {
        title: 'elderflower', # flori de soc
        start_date: '2001-05-01',
        end_date: '2001-05-31',
      },
      {
        title: 'carrot',
        start_date: '2001-05-01',
        end_date: '2001-07-31',
      },
      {
        title: 'parsnip', # păstârnac
        start_date: '2001-05-01',
        end_date: '2001-07-15',
      },
      {
        title: 'radishes', # ridichi
        start_date: '2001-05-01',
        end_date: '2001-07-15',
      },
      {
        title: 'basil', # busuioc
        start_date: '2001-05-15',
        end_date: '2001-08-15',
      },
      {
        title: 'pine nuts', # muguri de brad sirop
        start_date: '2001-05-01',
        end_date: '2001-07-15',
      },
      {
        title: 'sour cherries', # vișine
        start_date: '2001-06-01',
        end_date: '2001-07-31'
      },
      {
        title: 'raspberries',
        start_date: '2001-06-01',
        end_date: '2001-07-31'
      },
      {
        title: 'squash', # dovlecel
        start_date: '2001-06-01',
        end_date: '2001-08-31'
      },
      {
        title: 'apricots', # caise
        start_date: '2001-06-15',
        end_date: '2001-07-31'
      },
      {
        title: 'peas', # mazăre
        start_date: '2001-06-15',
        end_date: '2001-07-31'
      },
      {
        title: 'blackberries', # mure
        start_date: '2001-07-01',
        end_date: '2001-07-31'
      },
      {
        title: 'red pepper',
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'hot pepper',
        start_date: '2001-07-15',
        end_date: '2001-09-15'
      },
      {
        title: 'celery', # țelină
        start_date: '2001-07-15',
        end_date: '2001-09-30'
      },
      {
        title: 'egg plant',
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'watermelons',
        start_date: '2001-07-07',
        end_date: '2001-08-31'
      },
      {
        title: 'cantaloupe',
        start_date: '2001-07-07',
        end_date: '2001-08-31'
      },
      {
        title: 'tomatoes',
        start_date: '2001-06-01',
        end_date: '2001-09-15'
      },
      {
        title: 'kohlrabi', # gulie
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'black radish',
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'beet', # sfeclă
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'horseradish', # hrean
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'bean pods', # fasole pastai
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'cranberries', # afine
        start_date: '2001-07-15',
        end_date: '2001-08-31'
      },
      {
        title: 'beans', # fasole boabe
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'cucumber',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'potatoes',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'apples',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'pears',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'quince', # gutui
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'plums',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'nuts',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'dry onion',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'cauliflower',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'broccoli',
        start_date: '2001-08-01',
        end_date: '2001-09-30'
      },
      {
        title: 'grapes',
        start_date: '2001-09-01',
        end_date: '2001-09-30'
      },
      {
        title: 'leek', # praz
        start_date: '2001-09-01',
        end_date: '2001-10-15'
      },
      {
        title: 'cabbage',
        start_date: '2001-08-01',
        end_date: '2001-10-15'
      },
      {
        title: 'sea buckthorn', # cătină
        start_date: '2001-09-01',
        end_date: '2001-11-30'
      },
      {
        title: 'turnips', # napi
        start_date: '2001-01-01',
        end_date: '2001-02-28'
      },
      {
        title: 'cherries',
        start_date: '2001-05-15',
        end_date: '2001-07-31'
      },
      {
        title: 'strawberries',
        start_date: '2001-05-15',
        end_date: '2001-07-31'
      }
    ]
  end

  private

  def self.validate_array array
    unless array.map { |e| all.include?(e) }.select { |e| e == false }.empty?
      fail 'invalid array elements'
    end
  end
end
