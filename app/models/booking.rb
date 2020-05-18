class Booking < ApplicationRecord
    belongs_to :user
    validates :table_no, presence: true, 
                        length: {minimum: 1, maximum: 1}
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :duration, presence: true
end