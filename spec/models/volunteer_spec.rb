require "rails_helper"

describe Volunteer, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:role)}

    let(:nick) { Volunteer.create(name: "nick", role: 1) }
    let(:lori) { Volunteer.create(name: "lori", role: 1) }
    let(:adam) { Volunteer.create(name: "adam", role: 0) }
    let(:rachel) { Volunteer.create(name: "rachel", role: 0) }

    let(:vocals) { Instrument.create(name: "vocals") }
    let(:guitar) { Instrument.create(name: "guitar") }
    let(:acoustic) { Instrument.create(name: "acoustic") }
    let(:drums) { Instrument.create(name: "drums") }
    let(:bass) { Instrument.create(name: "bass") }

    before do
      vocals.volunteers << [nick, lori]
      guitar.volunteers << [adam]
      acoustic.volunteers << [nick]
      drums.volunteers << [rachel]
      bass.volunteers << [nick]
    end

    describe "singer?" do
      it "returns nick is a singer" do
        expect(nick.singer?).to be true
      end

      it "returns adam and rachel are not singers" do
        expect(adam.singer?).to be false
        expect(rachel.singer?).to be false
      end
    end

    describe "only_singer?" do
      it "returns lori is only a singer" do
        expect(lori.singer?).to be true
        expect(lori.only_singer?).to be true
      end

      it "returns nick is not only a singer" do
        expect(nick.singer?).to be true
        expect(nick.only_singer?).to be false
      end
    end

    describe "only instrumentalist" do
      it "returns adam and rachel are only instrumentalists" do
        expect(adam.only_instrumentalist?).to be true
        expect(rachel.only_instrumentalist?).to be true
      end

      it "returns nick and lori are not only instrumentalists" do
        expect(lori.only_instrumentalist?).to be false
        expect(nick.only_instrumentalist?).to be false
      end
    end
  end
end
