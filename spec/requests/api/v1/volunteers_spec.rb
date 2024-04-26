require 'rails_helper'

RSpec.describe "Api::V1::Volunteers", type: :request do
  let!(:nick)   { Volunteer.create(name: "nick", role: 1) }
  let!(:lori)   { Volunteer.create(name: "lori", role: 1) }
  let!(:adam)   { Volunteer.create(name: "adam") }
  let!(:rachel) { Volunteer.create(name: "rachel") }

  describe "GET /index" do
    it "returns success" do
      get api_v1_volunteers_path

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).count).to eq(4)
      expect(JSON.parse(response.body).first["name"]).to eq("nick")
      expect(JSON.parse(response.body).first["role"]).to eq("leader")
      expect(JSON.parse(response.body).last["name"]).to eq("rachel")
      expect(JSON.parse(response.body).last["role"]).to eq("basic")
    end
  end

  describe "GET /show" do
    it "returns success" do
      get api_v1_volunteer_path(nick.id)

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["name"]).to eq("nick")
      expect(JSON.parse(response.body)["role"]).to eq("leader")
      expect(JSON.parse(response.body)["id"]).to eq(nick.id)
    end
  end

  describe "POST /create" do
    it "returns success" do
      post api_v1_volunteers_path, params: { volunteer: { name: "frank" } }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["name"]).to eq("frank")
    end

    it "fails gracefully" do
      post api_v1_volunteers_path, params: { volunteer: {name: nil} }

      before_count = Volunteer.count
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)["error"]).to eq("unable to add volunteer")
      expect(Volunteer.count).to eq(before_count)
    end
  end

  describe "PATCH /update" do
    it "returns success" do
      put api_v1_volunteer_path(nick.id), params: { volunteer: {name: "rad"} }

      expect(response).to have_http_status(200)
      expect(nick.reload.name).to eq("rad")
    end

    it "fails gracefully" do
      put api_v1_volunteer_path(-1), params: { volunteer: {name: nil} }

      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)["error"]).to eq("Unable to update volunteer")
    end
  end

  describe "DELETE /destroy" do
    it "returns success" do
      delete api_v1_volunteer_path(nick.id)

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Volunteer removed")
      expect(Instrument.where(name: "vocals")).to eq([])
    end

    it "fails gracefully" do
      delete api_v1_volunteer_path(-1)

      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)["message"]).to eq("Error, volunteer not removed")
    end
  end
end
