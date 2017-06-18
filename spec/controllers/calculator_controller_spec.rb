require 'rails_helper'

RSpec.describe CalculatorController do
  describe '#calculator' do
    let(:params) { {} }

    let!(:calculator) {
      class_double('Calculator::Simple').tap do |d|
        d.as_stubbed_const
        allow(d).to receive(:call)
      end
    }

    before(:each) do
      get :calculator, params: params
    end

    it 'is reachable via GET /' do
      expect(get: '/').to route_to(controller: 'calculator',
                                   action: 'calculator')
    end

    it 'responds with a 200 status' do
      expect(response.status).to eq 200
    end

    it 'renders HTML' do
      expect(response.content_type).to eq 'text/html'
    end

    it 'renders the calculator/calculator template' do
      expect(response).to render_template('calculator/calculator')
    end

    context 'when no operation is specified' do
      it 'does not invoke the calculator' do
        expect(calculator).not_to have_received(:call)
      end

      it 'provides a nil result' do
        expect(subject.result).to be_nil
      end

      it 'provides a nil operation' do
        expect(subject.operation).to eq nil
      end

      it 'provides a nil error_message' do
        expect(subject.error_message).to be_nil
      end
    end

    context 'when an operation is specified' do
      let(:operation) { '1+2*3-4/5' }
      let(:params) { { operation: operation } }

      it 'invokes the calculator with the operation' do
        expect(calculator)
          .to have_received(:call)
                .with(operation: operation,
                      success: subject.method(:result=),
                      failure: subject.method(:error_message=))
      end

      context 'when the calculator indicates success' do
        let(:result) { 42 }

        let!(:calculator) {
          class_double('Calculator::Simple').tap do |d|
            d.as_stubbed_const
            allow(d).to receive(:call) { |success:, **_|
              success.call(result)
            }
          end
        }

        it 'provides the calculator result' do
          expect(subject.result).to eq result
        end

        it 'provides the requested operation' do
          expect(subject.operation).to eq operation
        end

        it 'provides a nil error_message' do
          expect(subject.error_message).to be_nil
        end
      end

      context 'when the calculator indicates failure' do
        let(:error_message) { 'Does not compute!' }

        let!(:calculator) {
          class_double('Calculator::Simple').tap do |d|
            d.as_stubbed_const
            allow(d).to receive(:call) { |failure:, **_|
              failure.call(error_message)
            }
          end
        }

        it 'provides a nil result' do
          expect(subject.result).to be_nil
        end

        it 'provides the requested operation' do
          expect(subject.operation).to eq operation
        end

        it 'provides the error message from the calculator' do
          expect(subject.error_message).to eq error_message
        end
      end
    end
  end
end
