class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def self.template_attr(*attr_names)
    attr_names.each do |attr_name|
      attr_accessor attr_name
      private "#{attr_name}="
    end
  end
end
