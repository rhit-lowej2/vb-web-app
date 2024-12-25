from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
import pyodbc
import os
from sqlalchemy import create_engine

def create_app(test_config=None):
    db = SQLAlchemy()
    username = 'sa'
    password = 'funky-penguin-cafe-train8'
    engine = create_engine("mssql+pyodbc://sa:funky-penguin-cafe-train8@localhost:1433/vbstat")
    app = Flask(__name__)
    app.config.from_mapping(
        SECRET_KEY='dev'
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    

    @app.route("/")
    def hello_world():
        return "<p>Hello, World!</p>"

    @app.route('/projects/')
    def projects():
        return 'The project page'

    @app.route('/about')
    def about():
        return render_template('about.html')
    
    return app