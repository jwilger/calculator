require 'calculator/simple'

RSpec.describe Calculator::Simple do
  subject {
    described_class.new(
      operation: operation,
      success: success_handler,
      failure: failure_handler
    )
  }

  let(:success_handler) {
    instance_double('Proc', 'success', call: nil)
  }

  let(:failure_handler) {
    instance_double('Proc', 'failure', call: nil)
  }

  before(:each) do
    subject.call
  end

  context 'when the provided operation contains characters other than ' \
          'integers or basic math operations' do
    let(:operation) { '2*(3+4)' }

    it 'does not call the success handler' do
      expect(success_handler).not_to have_received(:call)
    end

    it 'calls the failure handler with an error message' do
      expect(failure_handler)
        .to have_received(:call).with('Invalid symbols in operation. ' \
                                      'Only integers and basic math ' \
                                      'operators (+, -, *, and /) are ' \
                                      'supported.')
    end
  end

  context 'operation: 5*3+1+6/2+9*100' do
    let(:operation) { '5*3+1+6/2+9*100' }
    let(:expected_result) { 5.0*3.0+1.0+6.0/2.0+9.0*100.0 }

    it 'calls the success handler with the correct result, 919' do
      expect(success_handler).to have_received(:call).with(expected_result)
    end

    it 'does not call the failure handler' do
      expect(failure_handler).not_to have_received(:call)
    end
  end

  context 'operation: 5*3+1+6/85+9*100' do
    let(:operation) { '5*3+1+6/85+9*100' }
    let(:expected_result) { 5.0*3.0+1.0+6.0/85.0+9.0*100.0 }

    it 'calls the success handler with the correct result, 916.07' do
      expect(success_handler).to have_received(:call).with(expected_result)
    end

    it 'does not call the failure handler' do
      expect(failure_handler).not_to have_received(:call)
    end
  end

  context 'when the operation contains white space' do
    let(:operation) { "5 * 3 + 1  + 6 / 85 + 9\n * 100\t" }
    let(:expected_result) { 5.0*3.0+1.0+6.0/85.0+9.0*100.0 }
    it 'calls the success handler with the correct result, 916.07' do
      expect(success_handler).to have_received(:call).with(expected_result)
    end

    it 'does not call the failure handler' do
      expect(failure_handler).not_to have_received(:call)
    end
  end
end
