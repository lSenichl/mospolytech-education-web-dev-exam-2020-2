import os
from flask import Flask, render_template, abort, send_from_directory, Blueprint, render_template, redirect, url_for, request, current_app, flash
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import MetaData
from flask_migrate import Migrate

PER_PAGE = 5

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

naming_convention = {
    'pk': 'pk_%(table_name)s',
    'fk': 'fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s',
    'ix': 'ix_%(table_name)s_%(column_0_name)s',
    'uq': 'uq_%(table_name)s_%(column_0_name)s',
    'ck': 'ck_%(table_name)s_%(constraint_name)s',
}

db = SQLAlchemy(app, metadata=MetaData(naming_convention=naming_convention))
migrate = Migrate(app, db)

from models import Movie, Poster

from auth import bp as auth_bp, init_login_manager, check_rights
from crud import bp as crud_bp
from api import bp as api_bp

init_login_manager(app)

app.register_blueprint(auth_bp)
app.register_blueprint(crud_bp)
app.register_blueprint(api_bp)

@app.route('/')
def index():
    page = request.args.get('page', 1, type=int)
    pagination = Movie.query.order_by(Movie.production_year.desc()).paginate(page, PER_PAGE)
    movies = pagination.items
    
    return render_template('index.html', pagination=pagination, movies=movies)


@app.route('/posters/<poster_id>')
def poster(poster_id):
    img = Poster.query.get(poster_id)
    if img is None:
        abort(404)
    return send_from_directory(app.config['UPLOAD_FOLDER'], img.storage_filename)
