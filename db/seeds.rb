# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Volunteer.create(name: "nick", role: 1)
Volunteer.create(name: "lori", role: 1)
Volunteer.create(name: "adam")
Volunteer.create(name: "rachel")

vocals = Instrument.create(name: "vocals")
guitar = Instrument.create(name: "guitar")
acoustic = Instrument.create(name: "acoustic")
drums = Instrument.create(name: "drums")
bass = Instrument.create(name: "bass")

vocals.volunteers << Volunteer.find(1,2)
guitar.volunteers << Volunteer.find(3)
acoustic.volunteers << Volunteer.find(1)
drums.volunteers << Volunteer.find(4)
bass.volunteers << Volunteer.find(1)
