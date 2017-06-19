module Calculator
  class Simple
    def self.call(**args)
      new(**args).call
    end

    def initialize(operation:,
                   success: ->(result) { result },
                   failure: ->(error_message) { raise error_message })
      self.operation = operation
      self.success = success
      self.failure = failure
    end

    def call
      failure.call('Invalid symbols in operation. ' \
                   'Only integers and basic math ' \
                   'operators (+, -, *, and /) are ' \
                   'supported.')
    end

    private

    attr_accessor :operation, :success, :failure
  end
end
