import os
from flask import url_for
import sqlalchemy as sa
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
import markdown
from app import db
from sqlalchemy.dialects import mysql


class Genre(db.Model):
    __tablename__ = 'exam_genres'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128), nullable=False, unique=True)

    def __repr__(self):
        return '<Genre %r>' % self.name


genres = db.Table('exam_mtm_genre_movie', 
                            db.Column('movie_id', db.Integer, db.ForeignKey('exam_movies.id'), primary_key=True),
                            db.Column('genre_id', db.Integer, db.ForeignKey('exam_genres.id'), primary_key=True))


class Movie(db.Model):
    __tablename__ = 'exam_movies'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128), nullable=False)
    description = db.Column(db.Text(), nullable=False)
    production_year = db.Column(mysql.YEAR, nullable=False)
    country = db.Column(db.String(128), nullable=False)
    producer = db.Column(db.String(128), nullable=False)
    screenwriter = db.Column(db.String(128), nullable=False)
    actors = db.Column(db.String(256), nullable=False)
    duration = db.Column(db.Integer, nullable=False)

    rating_sum = db.Column(db.Integer, default=0)
    rating_num = db.Column(db.Integer, default=0)

    poster_id = db.Column(db.String(36), db.ForeignKey('exam_posters.id'), nullable=False)

    poster = db.relationship('Poster', backref='movies')
    genres = db.relationship('Genre', secondary=genres, backref=db.backref('movies', lazy='dynamic'))

    def __repr__(self):
        return '<Movie %r>' % self.name

    @property
    def rating(self):
        if self.rating_num > 0:
            return self.rating_sum/self.rating_num
        else:
            return 0


class Poster(db.Model):
    __tablename__ = 'exam_posters'

    id = db.Column(db.String(36), primary_key=True)
    file_name = db.Column(db.String(128), nullable=False)
    mime_type = db.Column(db.String(128), nullable=False)
    md5_hash = db.Column(db.String(128), nullable=False, unique=True)

    def __repr__(self):
        return '<Genre %r>' % self.name

    @property
    def url(self):
        return url_for('Poster', poster_id=self.id)

    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.file_name)
        return self.id + ext


class Review(db.Model):
    __tablename__ = 'exam_reviews'

    id = db.Column(db.Integer, primary_key=True)

    movie_id = db.Column(db.Integer, db.ForeignKey('exam_movies.id'), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('exam_users.id'), nullable=False)

    rating = db.Column(db.Integer, nullable=False)
    text = db.Column(db.Text(), nullable=False)
    created_at = db.Column(db.DateTime, nullable=False, server_default=sa.sql.func.now())

    movie = db.relationship('Movie', backref='reviews')
    user = db.relationship('User', backref='reviews')

    def __repr__(self):
        return '<Review %r>' % self.name


class User(db.Model, UserMixin):
    __tablename__ = 'exam_users'

    id = db.Column(db.Integer, primary_key=True)
    login = db.Column(db.String(128), nullable=False, unique=True)
    password_hash = db.Column(db.String(128), nullable=False)
    last_name = db.Column(db.String(128), nullable=False)
    first_name = db.Column(db.String(128), nullable=False)
    middle_name = db.Column(db.String(128))

    role_id = db.Column(db.Integer, db.ForeignKey('exam_roles.id'))

    role = db.relationship('Role', backref='users')

    def __repr__(self):
        return '<User %r>' % self.name

    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)


class Role(db.Model):
    __tablename__ = 'exam_roles'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128), nullable=False)
    desc = db.Column(db.Text(), nullable=False)

    def __repr__(self):
        return '<Role %r>' % self.name