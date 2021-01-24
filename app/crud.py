import os
import bleach
from flask import Blueprint, render_template, redirect, url_for, request, flash
from flask_login import login_required, current_user
from tools import ImageSaver
from models import Movie, Review, Genre
from auth import check_rights
from config import UPLOAD_FOLDER

from app import db

bp = Blueprint('crud', __name__, url_prefix='/crud')

PERMITTED_PARAMS = ['name', 'production_year', 'country',
                    'producer', 'screenwriter', 'actors', 'duration']
PERMITTED_REVIEW_PARAMS = ['user_id', 'movie_id', 'text', 'rating']

PER_PAGE = 5


def params():
    return {p: request.form.get(p) for p in PERMITTED_PARAMS}


def review_params():
    return {p: request.form.get(p) for p in PERMITTED_REVIEW_PARAMS}


@bp.route('/read/<int:movie_id>')
def read(movie_id):
    movie = Movie.query.get(movie_id)

    ncur = []
    cur = None

    if current_user.is_authenticated:
        for review in movie.reviews:
            if current_user.id == review.user_id:
                cur = review
                print(cur.is_moderated)
            else:
                if review.is_moderated == 'Одобрено':
                    ncur.append(review)
    else:
        ncur = movie.reviews

    return render_template('crud/read_film.html', movie=movie, ncur=ncur, cur=cur)


@bp.route('/read/<int:movie_id>/create_review', methods=['POST', 'GET'])
@login_required
def create_review(movie_id):
    movie = Movie.query.get(movie_id)

    if request.method == "POST":
        review = Review(**review_params())
        review.text = bleach.clean(request.form.get('text'))
        db.session.add(review)
        db.session.commit()
        #movie.rating_num = movie.rating_num+1
        #movie.rating_sum = movie.rating_sum+int(request.form.get('rating'))
        db.session.add(movie)
        db.session.commit()
        flash("Рецензия успешно оставлена", "success")

        return redirect(url_for('crud.read', movie_id=movie_id))

    return render_template('crud/create_review.html', movie_id=movie_id)


@bp.route('/create')
@login_required
@check_rights('create_movie')
def create():
    genres = Genre.query.all()

    return render_template('crud/create_film.html', genres=genres)


@bp.route('/new', methods=['POST'])
@login_required
@check_rights('create_movie')
def new():
    f = request.files.get('background_img')
    img = None
    if f and f.filename:
        img_saver = ImageSaver(f)
        img = img_saver.save()

    description = bleach.clean(request.form.get('description'))
    genres = request.form.getlist('genre_ids')

    movie = Movie(**params(), poster_id=img.id, description=description)

    db.session.add(movie)

    for genre_id in genres:
        genre = Genre.query.filter(Genre.id == genre_id).first()
        movie.genres.append(genre)

    if img:
        img_saver.bind_to_object(movie)

    db.session.commit()

    flash(f'Фильм {movie.name} был успешно добавлен!', 'success')

    return redirect(url_for('index'))


@bp.route('/update/<int:movie_id>')
@login_required
@check_rights('update_movie')
def update(movie_id):
    movie = Movie.query.get(movie_id)
    genres = Genre.query.all()

    return render_template('crud/update_film.html', movie=movie, genres=genres)


@bp.route('/update', methods=['POST'])
@login_required
@check_rights('update_movie')
def update_q():
    movie_id = request.args.get('movie_id')

    movie = Movie.query.filter(Movie.id == movie_id).first()

    description = bleach.clean(request.form.get('description'))
    genres = request.form.getlist('genre_ids')

    movie.name = request.form.get('name')
    movie.production_year = request.form.get('production_year')
    movie.country = request.form.get('country')
    movie.producer = request.form.get('producer')
    movie.screenwriter = request.form.get('screenwriter')
    movie.actors = request.form.get('actors')
    movie.duration = request.form.get('duration')
    movie.description = description

    print(genres)
    print(movie.genres)

    temp_genres = []
    for i in movie.genres:
        temp_genres.append(i)

    for genre_id_del in temp_genres:
        print('remove' + str(genre_id_del))
        genre_del = Genre.query.filter(Genre.name == genre_id_del.name).first()
        movie.genres.remove(genre_del)

    db.session.add(movie)

    for genre_id_add in genres:
        print('add' + str(genre_id_add))
        genre_add = Genre.query.filter(Genre.id == genre_id_add).first()
        if genre_add not in movie.genres:
            movie.genres.append(genre_add)

    db.session.commit()

    flash(f'Фильм {movie.name} был успешно обновлён!', 'success')

    return redirect(url_for('index'))


@bp.route('/delete/<int:movie_id>', methods=['POST'])
@login_required
@check_rights('delete_movie')
def delete(movie_id):
    movie = Movie.query.get(movie_id)

    os.remove(UPLOAD_FOLDER + '/' + str(movie.poster.storage_filename))

    db.session.delete(movie)
    db.session.commit()

    flash('Фильм успешно удалён', 'success')
    return redirect(url_for('index'))
