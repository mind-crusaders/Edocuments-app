# frozen_string_literal: true

require 'roda'
require 'slim'

module Edocument
  # Base class for Edocument Web Application
  class App < Roda
    plugin :render, engine: 'slim', views: 'views'
    plugin :assets, css: 'style.css', path: 'assets'
    plugin :public, root: 'public'
    plugin :multi_route
    plugin :flash

    route do |routing|
      @current_user = Session.new(SecureSession.new(session)).get_user

      routing.public
      routing.assets
      routing.multi_route

      # GET /
      routing.root do
        view 'home', locals: { current_user: @current_user }
      end
    end
  end
end
