class ChurchesPerson < ActiveRecord::Base
  belongs_to :church
  belongs_to :person
  
  validates :end_date_month, exclusion: { in: [0], message: "Can't be zero"}
  validates :start_date_month, exclusion: { in: [0], message: "Can't be zero"}
  validates :start_date_day, :inclusion => { :in => 1..31, :message => "Start day must be 1-31"}, :allow_nil => true
  validates :end_date_day, :inclusion => { :in => 1..31, :message => "End day must be 1-31"}, :allow_nil => true
  validate :dates_cannot_overlap_on_unique_church_positions
  
  
  accepts_nested_attributes_for :person
  
  UNIQUE_CHURCH_POSITIONS = ["incumbent"]
  
  def dates_cannot_overlap_on_unique_church_positions
    if church_position.present? && UNIQUE_CHURCH_POSITIONS.include?(church_position.downcase)
      ChurchesPerson.where(church: church, church_position: church_position).where.not(id: id).each do |cp|
        if cp.end_date_date(Date.today + 1000.years) > start_date_date(Date.today - 1000.years) &&
          cp.start_date_date(Date.today - 1000.years) < end_date_date(Date.today + 1000.years)
          errors.add(:start_date_day, "start day overlaps with existing record")
          errors.add(:start_date_month, "start month overlaps with existing record")
          errors.add(:start_date_year, "start year overlaps with existing record")
          break
        end
      end
    end
  end
  
  
  def is_current?
    start_date_date = make_date(start_date_year,start_date_month,start_date_day, Time.now - 100.years)
    end_date_date = make_date(end_date_year,end_date_month,end_date_day,Time.now + 100.years)
    if start_date_date <= Date.today && end_date_date > Date.today
      return true
    else
      return false
    end
  end
  
  def self.ending_soon(time_from_now = 6.months)
    churches_people = []
    target_time = Time.now + time_from_now
    initial_set = self.where("end_date_year > ?", Time.now.year - 1)
    initial_set.each do |cp|
      if cp.end_date_day == nil and cp.end_date_month == nil
        if Time.new(mr.end_date_year,1,1) < target_time
          churches_people << cp
        end
      elsif cp.end_date_day == nil
        if Time.new(cp.end_date_year,cp.end_date_month,1) < target_time
          churches_people << cp
        end
      else
        if Time.new(cp.end_date_year,cp.end_date_month, cp.end_date_day) < target_time
         churches_people << cp
        end
      end
    end
    return churches_people.sort_by{|cp| Time.new(cp.end_date_year, cp.end_date_month, cp.end_date_day) }
  end
  
  
  def tidy_dates
    (tidy_start_date_date.length > 0 ? tidy_start_date_date : "?") + " - " + (tidy_end_date_date.length > 0 ? tidy_end_date_date : "?")
  end
  
  def tidy_start_date_date
    string = ""
    if (start_date_day.is_a? Integer)
      string += start_date_day.to_s
      string += " "
    end
    if (start_date_month.is_a? Integer)
      string += Date::MONTHNAMES[start_date_month]
      string += " "
    end
    if (start_date_year.is_a? Integer)
      string += start_date_year.to_s
    end
    return string
  end
  
  def tidy_end_date_date
    string = ""
    if (end_date_day.is_a? Integer)
      string += end_date_day.to_s
      string += " "
    end
    if (end_date_month.is_a? Integer)
      string += Date::MONTHNAMES[end_date_month]
      string += " "
    end
    if (end_date_year.is_a? Integer)
      string += end_date_year.to_s
    end
    return string
  end
  
  # getters to simplify dates
  def start_date_date(date_if_blank = false)
    return make_date(start_date_year,start_date_month,start_date_day,date_if_blank)
  end
  
  def end_date_date(date_if_blank = false) 
    return make_date(end_date_year,end_date_month,end_date_day,date_if_blank)
  end
  
  # Setters to simplify setting of dates
  
  def start_date_date=(date)
    self[:start_date_day] = date.day
    self[:start_date_month] = date.month
    self[:start_date_year] = date.year
  end
  
  def end_date_date=(date)
    self[:end_date_day] = date.day
    self[:end_date_month] = date.month
    self[:end_date_year] = date.year
  end
  
  def make_date(year,month,day,date_if_blank = false)
    if year.is_a? Integer
      if month.is_a? Integer
        if day.is_a? Integer
           return Time.new(year,month,day)
        else
          return Time.new(year,month)
        end 
      else
        return Time.new(year)
      end
    else
      return date_if_blank
    end
  end 
end
