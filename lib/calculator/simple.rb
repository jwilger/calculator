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
      return unless valid_operation?
      self.result = operation.dup
      perform_multiplication_and_division
      perform_addition_and_subtraction
      success.call(result.to_f)
    end

    private

    attr_accessor :operation, :success, :failure, :result

    def valid_operation?
      return true if /^[\d+\-*\/]*$/ =~ operation
      failure.call('Invalid symbols in operation. ' \
                   'Only integers and basic math ' \
                   'operators (+, -, *, and /) are ' \
                   'supported.')
      false
    end

    def perform_multiplication_and_division
      perform_operation_set('*/')
    end

    def perform_addition_and_subtraction
      perform_operation_set('+-')
    end

    def perform_operation_set(operation_set)
      while %r{[#{operation_set}]} =~ result
        result.sub!(%r{(\d+(\.\d+)?)([#{operation_set}])(\d+(\.\d+)?)}) do
          lhs = $1.to_f
          operator = $3
          rhs = $4.to_f
          lhs.send(operator, rhs)
        end
      end
    end
  end
end
