class Instrument < ApplicationRecord
  has_many :volunteer_instruments
  has_many :volunteers, through: :volunteer_instruments

  validates_presence_of :name
end
