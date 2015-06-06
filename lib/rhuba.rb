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

class Rhubarb

  REQUIRED_KEYS = %w(key start_date end_date)

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
      s += "#{e[:key]}: #{e[:start_date].nowify.pretify} -> #{e[:end_date].nowify.pretify}\n"
    end
    s
  end

  def self.tldr(array)
    validate_array(array)
    "TLDR: #{array.collect{|e| e[:key]}.join(', ')}"
  end

  def self.all
    [
      {
        key: 'rhubarb',
        start_date: '2001-04-01',
        end_date: '2001-06-01',
        img: {
          src: 'https://stocksnap.io/photo/YOU6942709',
          direct: 'https://snap-photos.s3.amazonaws.com/img-thumbs/960w/YOU6942709.jpg'
        }
      }
    ]
  end

  def self.table
    [
      ['none',         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],

      # Fruit          J  F  M  A  M  I  I  A  S  O  N  D
      ['apricots',     0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
      ['blackberries', 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      ['blueberries',  0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
      ['cherries',     0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0],
      ['grapes',       0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0],
      ['melons',       0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0],
      ['nectarines',   0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      ['peaches',      0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
      ['plums',        0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0],
      ['rhubarb',      0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
      ['strawberries', 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0],

      # Vegatables     J  F  M  A  M  I  I  A  S  O  N  D
    ]
  end

  private

  def self.validate_array array
    unless array.map { |e| all.include?(e) }.select { |e| e == false }.empty?
      fail 'invalid array elements'
    end
  end
end
