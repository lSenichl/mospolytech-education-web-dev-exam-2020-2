from flask import Blueprint, jsonify, request
from tools import ImageSaver

bp = Blueprint('api', __name__, url_prefix='/api')


@bp.route('/images/upload', methods=['POST'])
def upload_image():
    f = request.files.get('image')
    if f and f.filename:
        img_saver = ImageSaver(f)
        img = img_saver.save()
        return jsonify({'data': {'filePath': img.url, 'imageId': img.id}})
    return jsonify({'error': 'noFileGiven'})
