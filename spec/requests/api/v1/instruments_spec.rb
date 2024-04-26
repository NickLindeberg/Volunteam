require 'rails_helper'

RSpec.describe "Api::V1::Instruments", type: :request do
  let!(:vocals)   { Instrument.create(name: "vocals") }
  let!(:guitar)   { Instrument.create(name: "guitar") }
  let!(:acoustic) { Instrument.create(name: "acoustic") }
  let!(:drums)    { Instrument.create(name: "drums") }
  let!(:bass)     { Instrument.create(name: "bass") }

  describe "GET /index" do
    it "returns success" do
      get api_v1_instruments_path

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(5)
      expect(JSON.parse(response.body).first["name"]).to eq("vocals")
      expect(JSON.parse(response.body).last["name"]).to eq("bass")
    end
  end

  describe "GET /show" do
    it "returns success" do
      get api_v1_instrument_path(vocals.id)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["name"]).to eq("vocals")
      expect(JSON.parse(response.body)["id"]).to eq(vocals.id)
    end
  end

  describe "POST /create" do
    it "returns success" do
      post api_v1_instruments_path, params: { instrument: { name: "keytar" } }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["name"]).to eq("keytar")
    end

    it "fails gracefully" do
      post api_v1_instruments_path, params: { instrument: {name: nil} }

      before_count = Instrument.count
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)["error"]).to eq("unable to add instrument")
      expect(Instrument.count).to eq(before_count)
    end
  end

  describe "PATCH /update" do
    it "returns success" do
      put api_v1_instrument_path(guitar.id), params: { instrument: {name: "electric"} }

      expect(response).to have_http_status(200)
      expect(guitar.reload.name).to eq("electric")
    end

    it "fails gracefully" do
      put api_v1_instrument_path(-1), params: { instrument: {name: nil} }

      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)["error"]).to eq("Unable to update instrument")
    end
  end

  describe "DELETE /destroy" do
    it "returns success" do
      delete api_v1_instrument_path(vocals.id)

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Instrument removed")
      expect(Instrument.where(name: "vocals")).to eq([])
    end

    it "fails gracefully" do
      delete api_v1_instrument_path(-1)

      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)["message"]).to eq("Error, instrument not removed")
    end
  end
end
