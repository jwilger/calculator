require 'rails_helper'

RSpec.describe CalculatorController do
  describe '#calculator' do
    it 'is reachable via GET /' do
      expect(get: '/').to route_to(controller: 'calculator',
                                   action: 'calculator')
    end

    it 'responds with a 200 status' do
      get :calculator
      expect(response.status).to eq 200
    end

    it 'renders HTML' do
      get :calculator
      expect(response.content_type).to eq 'text/html'
    end

    it 'renders the calculator/calculator template' do
      get :calculator
      expect(response).to render_template('calculator/calculator')
    end
  end
end
