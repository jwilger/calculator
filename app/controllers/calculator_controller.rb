class CalculatorController < ApplicationController
  template_attr :operation, :result, :error_message

  def calculator
    self.operation = params[:operation]
    return if operation.blank?
    Calculator::Simple.call(
      operation: operation,
      success: method(:result=),
      failure: method(:error_message=)
    )
  end
end
