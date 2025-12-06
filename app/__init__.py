from flask import Flask
from app.routes.user_routes import user_blueprint
from app.routes.product_routes import product_blueprint
from prometheus_client import Counter, make_wsgi_app
from werkzeug.middleware.dispatcher import DispatcherMiddleware

def create_app():
    app = Flask(__name__)

    # Register blueprints
    app.register_blueprint(user_blueprint)
    app.register_blueprint(product_blueprint)

    # -----------------------
    # Prometheus metrics setup
    # -----------------------
    # Example metric: total HTTP requests
    REQUEST_COUNT = Counter('app_requests_total', 'Total number of requests')

    @app.before_request
    def before_request():
        REQUEST_COUNT.inc()

    # Expose metrics at /metrics
    app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {
        '/metrics': make_wsgi_app()
    })

    return app