require 'rails_helper'
require 'spec_helper'

describe AirplanesController do
  describe '#index' do
    it 'should be successful response if params are empty' do
      get :index
      expect(response).to be_successful
      expect(response.status).to eq 200
    end

    it 'should be return empty response if seats are blank' do
      get :index, params: {seats: nil, passenger: 1}
      expect(response.body).to eq('')
    end

    it 'should be render template if passenger count exceeds passenger limit' do
      get :index, params: {seats: "[[3,4], [4,5], [2,3], [3,4]]", passenger: 100}
      expect(response).to render_template('airplanes/output_template')
    end

    it 'should be render template if params are valid' do
      get :index, params: {seats: "[[3,4], [4,5], [2,3], [3,4]]", passenger: 50}
      expect(response).to render_template('airplanes/output_template')
    end

    it 'should not render template if params seat is empty' do
      get :index
      expect(response).not_to render_template('airplanes/output_template')
    end

    it 'should not render template if params passenger is empty' do
      get :index, params: {seats: "[[3,4], [4,5], [2,3], [3,4]]", passenger: nil}
      expect(response).not_to render_template('airplanes/output_template')
    end

  end
end