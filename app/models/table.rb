class Table < ApplicationRecord
    has_many :bookings, dependent: :destroy
    validates :number, presence: true, uniqueness: true
end