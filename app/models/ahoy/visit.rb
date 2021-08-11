class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true

  # Returns only visits from the past week
  scope :this_week, -> {
    where("started_at > ?", 1.week.ago)
  }

  # Returns a hash .. class method: bowsers that have visited and their sum
  def self.browsers
           group(:browser).count
  end

  # Returns a hash .. class method: OS's that have visited and their sum
  def self.operating_systems
           group(:os).count
  end

  # Returns a hash .. class method: cities that have visited and their sum
  def self.devices
           group(:device_type).count
  end

  # Returns a hash .. class method: countries that have visited and their sum
  def self.countries
           group(:country).count
  end

  # Returns a hash .. class method: regions that have visited and their sum
  def self.regions
           group(:region).count
  end

  # Returns a hash .. class method: cities that have visited and their sum
  def self.cities
           group(:city).count
  end

  # Returns an array .. class method: number of visits month over year
  def self.month_of_year_visits
           group_by_month_of_year(:started_at)
          .count
          .map{ |k, v| [I18n.t("date.month_names")[k], v] }
  end

end