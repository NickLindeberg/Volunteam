class VolunteerInstrument < ApplicationRecord
  belongs_to :instrument
  belongs_to :volunteer
end
