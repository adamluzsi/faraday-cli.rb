class MW

  def initialize(app)
    @app = app
  end

  def call(env)
    puts env.object_id
    @app.call(env)
  end

end

use MW