module Hello
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request      = ActionDispatch::Request.new(env)
      env['hello'] = Hello::RequestManager.create(request)
      response     = @app.call(env)
    end
  end
end
