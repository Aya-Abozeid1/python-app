from flask import Flask
from app.routes.user_routes import user_blueprint
from app.routes.product_routes import product_blueprint

from prometheus_client import generate_latest, CONTENT_TYPE_LATEST
from prometheus_client import Counter
from flask import Response

# Example custom metric
REQUEST_COUNT = Counter("app_requests_total", "Total requests to the Python app")

def create_app():
    app = Flask(__name__)

    # Register blueprints
    app.register_blueprint(user_blueprint)
    app.register_blueprint(product_blueprint)

    # Count all requests
    @app.before_request
    def before_request():
        REQUEST_COUNT.inc()

    # Add /metrics endpoint manually
    @app.route("/metrics")
    def metrics():
        return Response(generate_latest(), mimetype=CONTENT_TYPE_LATEST)

    return app
