from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

# Initialize the extension SQLAlchemy
db = SQLAlchemy()

def create_app():
    app = Flask(__name__, static_folder="assets")

    # Project settings
    app.config.from_mapping(
        DEBUG = True,
        SECRET_KEY = 'd9d3e93eead4ddaa24436a0ed3b1dc6f47cbb9207b9b8ebd',
        SQLALCHEMY_DATABASE_URI = 'sqlite:///app_data.db'
    )

    # initialize the app with the extension SQLAlchemy
    db.init_app(app)

    # Registering Blueprints
    from . import todo_views # The dot (".") is the current package
    app.register_blueprint(todo_views.bp)

    from . import auth_views
    app.register_blueprint(auth_views.bp)

    @app.route('/')
    def index():
        return render_template('index.html')
    
    # To create the tables schemas in the database:
    # migrate application models
    with app.app_context():
        db.create_all()
    
    return app