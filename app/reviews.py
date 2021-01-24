from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
from users_policy import UsersPolicy
from functools import wraps
from models import Movie, Review, User, Genre
from auth import check_rights

from app import db

PER_PAGE = 5

bp = Blueprint('reviews', __name__, url_prefix='/reviews')

@bp.route('/not_moderated')
@login_required
@check_rights('moderate_reviews')
def not_moderated():
    page = request.args.get('page', 1, type=int)
    pagination = Review.query.order_by(Review.created_at.desc()).filter(Review.is_moderated == 'На рассмотрении').paginate(page, PER_PAGE)
    reviews = pagination.items

    return render_template('reviews/not_moderated.html', pagination=pagination, reviews=reviews)


@bp.route('/confirmed')
@login_required
@check_rights('moderate_reviews')
def confirmed():
    page = request.args.get('page', 1, type=int)
    pagination = Review.query.order_by(Review.created_at.desc()).filter(Review.is_moderated == 'Одобрено').paginate(page, PER_PAGE)
    reviews = pagination.items
    
    return render_template('reviews/confirmed.html', pagination=pagination, reviews=reviews)


@bp.route('/canceled')
@login_required
@check_rights('moderate_reviews')
def canceled():
    page = request.args.get('page', 1, type=int)
    pagination = Review.query.order_by(Review.created_at.desc()).filter(Review.is_moderated == 'Отклонено').paginate(page, PER_PAGE)
    reviews = pagination.items
    
    return render_template('reviews/canceled.html', pagination=pagination, reviews=reviews)


@bp.route('/user_reviews')
@login_required
def user_reviews():
    page = request.args.get('page', 1, type=int)
    pagination = Review.query.order_by(Review.created_at.desc()).filter(Review.user == current_user).paginate(page, PER_PAGE)
    reviews = pagination.items
    
    return render_template('reviews/user_reviews.html', pagination=pagination, reviews=reviews)


@bp.route('/read_review/<int:review_id>')
@login_required
@check_rights('moderate_reviews')
def read_review(review_id):
    review = Review.query.filter(Review.id == review_id).first()
    
    return render_template('reviews/read_review.html', review=review)


@bp.route('/confirm_cancel')
@login_required
@check_rights('moderate_reviews')
def confirm_cancel():
    review_id = request.args.get('review_id')
    confirm = request.args.get('confirm')
    print(confirm)

    review = Review.query.filter(Review.id == review_id).first()
    
    if confirm == True:
        review.is_moderated = 'Одобрено'
        print(review.is_moderated)
        flash("Рецензия успешно одобрена", "success")
    else:
        review.is_moderated = 'Отклонено'
        print(review.is_moderated)
        flash("Рецензия успешно отклонена", "success")

    db.session.commit()

    return redirect(url_for('reviews.not_moderated'))