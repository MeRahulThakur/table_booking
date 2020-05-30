class Booking < ApplicationRecord
    belongs_to :user
    validates :user, presence: true
    validates :table_no, presence: true, 
                        length: {minimum: 1, maximum: 1}
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 10, :less_than_or_equal_to => 60, :message => "Duration Should be Betweem 10 & 60 minutes"}
    validate  :minimum_time_gap_for_user
    validate :overlapping_booking_check

    attr_accessor :duration

    before_validation :set_end_time
    def booking_duration
        ((self.end_time - self.start_time)/60).to_i
    end

    def set_start_time 
        # self.start_time = DateTime.strptime(self.start_time, '%Y-%m-%dT%H:%M:%S%z')  
        self.start_time = self.start_time.strftime('%Y-%m-%dT%H:%M:%S%z')  
    end
     
    def set_end_time
        set_start_time
       self.end_time = self.start_time + self.duration.to_i.minutes
    end
   
    def minimum_time_gap_for_user
       if (self.user.bookings.where("(end_time >=? and start_time <= ?) OR (start_time <=? and start_time >= ? ) ", self.start_time - 60.minutes,self.start_time,self.end_time + 60.minutes,self.end_time).count > 0)
         errors.add :minimun_interval, "of 1 hour between two bookings for the same user."
       end
    end
   
    def overlapping_booking_check
       if (Booking.where("table_no = ? AND (start_time <= ? and end_time >= ?)", self.table_no, self.end_time, self.start_time).count > 0)
         errors.add :table, "not available in the given time interval due to overlap with other Booking."
       end
    end
end