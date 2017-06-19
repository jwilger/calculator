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

  context 'when the provided operation contains characters other than ' \
          'integers or basic math operations' do
    let(:operation) { '2*(3+4)' }

    it 'does not call the success handler' do
      subject.call
      expect(success_handler).not_to have_received(:call)
    end

    it 'calls the failure handler with an error message' do
      subject.call
      expect(failure_handler)
        .to have_received(:call).with('Invalid symbols in operation. ' \
                                      'Only integers and basic math ' \
                                      'operators (+, -, *, and /) are ' \
                                      'supported.')
    end
  end
end
