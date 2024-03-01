class Volunteer < ApplicationRecord
  has_many :volunteer_instruments
  has_many :instruments, through: :volunteer_instruments

  validates_presence_of :name, :role

  enum :role, {basic: 0, leader: 1}

  def singer?
    music_roles.any?("vocals")
  end

  def only_singer?
    music_roles.all?("vocals")
  end

  def only_instrumentalist?
    music_roles.none?("vocals")
  end

  private

  def music_roles
    instruments.pluck(:name)
  end
end
