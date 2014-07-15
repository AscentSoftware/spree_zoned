module SpreeZoned
  module ActiveZone
    class SessionMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        request = ActionDispatch::Request.new(env)
        Session.begin_session(request.cookie_jar)

        @app.call(env)
      ensure
        Session.end_session
      end

      def logger
        Rails.logger
      end
    end
  end
end
