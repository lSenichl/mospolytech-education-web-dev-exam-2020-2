import os
import bleach
from flask import Blueprint, render_template, redirect, url_for, request, current_app, flash
from flask_login import login_required, current_user
#from tools import 
from models import Movie, Review
from auth import check_rights

from app import db

bp = Blueprint('crud', __name__, url_prefix='/crud')

PERMITTED_REVIEW_PARAMS = ['user_id', 'movie_id', 'text', 'rating']

PER_PAGE = 5

def review_params():
    return { p: request.form.get(p) for p in PERMITTED_REVIEW_PARAMS }

@bp.route('/read/<int:movie_id>')
def read(movie_id):
    movie = Movie.query.get(movie_id)

    ncur = []
    cur = None
    for review in movie.reviews:
        if current_user.is_authenticated:
            if current_user.id != review.user_id:
                ncur.append(review)
            else:
                cur = review
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
        movie.rating_num = movie.rating_num+1
        movie.rating_sum = movie.rating_sum+int(request.form.get('rating'))
        db.session.add(movie)
        db.session.commit()
        flash("Рецензия успешно оставлена", "success")

        return  redirect(url_for('crud.read', movie_id=movie_id))

    return render_template('crud/create_review.html', movie_id=movie_id)


@bp.route('/update/<int:movie_id>')
@login_required
@check_rights('update_movie')
def update(movie_id):
    return render_template('crud/update_film.html', movie_id=movie_id)


@bp.route('/delete/<int:movie_id>')
@login_required
@check_rights('delete_movie')
def delete(movie_id):
    flash('Фильм успешно удалён', 'success')
    return redirect(url_for('index'))
