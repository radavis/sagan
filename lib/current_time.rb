require "core_ext/time"

class CurrentTime
  attr_reader :zone

  def initialize(zone = "America/New_York")
    @zone = zone
    Time.zone = zone
  end

  def working_hours?
    !weekend? && (nine_am < now && now < five_pm)
  end

  def weekend?
    ["Saturday", "Sunday"].include?(day)
  end

  private

  def day
    now.strftime("%A")
  end

  def now
    Time.current
  end

  def nine_am
    now.beginning_of_day + 9.hours
  end

  def five_pm
    now.beginning_of_day + 17.hours
  end
end
