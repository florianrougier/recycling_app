# -*- coding: utf-8 -*-

from scripts import tabledef
from scripts import forms
from scripts import helpers
from imageio import imwrite, imread
from flask import Flask, flash, send_from_directory, redirect, url_for, render_template, request, session, jsonify
from werkzeug.utils import secure_filename
from fastai.vision import *
import fastai as fa
import json
import sys
import os

# Stage 2: Load the pretrained model

# Loading the model
model = load_learner('', 'trained_model.pkl')

app = Flask(__name__)
app.secret_key = os.urandom(12)  # Generic key for dev purposes only

# Define the upload directory for images and allowed extensions
UPLOAD_DIRECTORY = "uploads/"
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

# Heroku
#from flask_heroku import Heroku
#heroku = Heroku(app)

# ======== Routing =========================================================== #
# -------- Login ------------------------------------------------------------- #
@app.route('/', methods=['GET', 'POST'])
def login():
    if not session.get('logged_in'):
        form = forms.LoginForm(request.form)
        if request.method == 'POST':
            username = request.form['username'].lower()
            password = request.form['password']
            if form.validate():
                if helpers.credentials_valid(username, password):
                    session['logged_in'] = True
                    session['username'] = username
                    return json.dumps({'status': 'Login successful'})
                return json.dumps({'status': 'Invalid user/pass'})
            return json.dumps({'status': 'Both fields required'})
        return render_template('login.html', form=form)
    user = helpers.get_user()
    return render_template('home.html', user=user)


@app.route("/logout")
def logout():
    session['logged_in'] = False
    return redirect(url_for('login'))


# -------- Signup ---------------------------------------------------------- #
@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if not session.get('logged_in'):
        form = forms.LoginForm(request.form)
        if request.method == 'POST':
            username = request.form['username'].lower()
            password = helpers.hash_password(request.form['password'])
            email = request.form['email']
            if form.validate():
                if not helpers.username_taken(username):
                    helpers.add_user(username, password, email)
                    session['logged_in'] = True
                    session['username'] = username
                    return json.dumps({'status': 'Signup successful'})
                return json.dumps({'status': 'Username taken'})
            return json.dumps({'status': 'User/Pass required'})
        return render_template('login.html', form=form)
    return redirect(url_for('login'))


# -------- Settings ---------------------------------------------------------- #
@app.route('/settings', methods=['GET', 'POST'])
def settings():
    if session.get('logged_in'):
        if request.method == 'POST':
            password = request.form['password']
            if password != "":
                password = helpers.hash_password(password)
            email = request.form['email']
            helpers.change_user(password=password, email=email)
            return json.dumps({'status': 'Saved'})
        user = helpers.get_user()
        return render_template('settings.html', user=user)
    return redirect(url_for('login'))


# -------- Files listing ---------------------------------------------------------- #
@app.route("/files")
def list_files():
    """Endpoint to list files on the server."""
    files = []
    for filename in os.listdir(UPLOAD_DIRECTORY):
        path = os.path.join(UPLOAD_DIRECTORY, filename)
        if os.path.isfile(path):
            files.append(filename)
    return jsonify(files)


# -------- Download a file  ---------------------------------------------------------- #
@app.route("/files/<path:path>")
def get_file(path):
    """Download a file."""
    return send_from_directory(UPLOAD_DIRECTORY, path, as_attachment=True)


# -------- Upload a file ---------------------------------------------------------- #
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/files/<filename>", methods=["POST"])
def post_file(filename):
    """Upload a file."""

    if "/" in filename:
        # Return 400 BAD REQUEST
        abort(400, "no subdirectories directories allowed")

    file = request.files['file']

    # if user does not select file, browser also
    # submit an empty part without filename
    if file.filename == '':
        flash('No selected file')
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(UPLOAD_DIRECTORY, filename))
        # Return 201 CREATED
        return "File uploaded successfully", 201
    else:
        return "File not uploaded"


# -------- Prediction route ---------------------------------------------------------- #
@app.route("/api/v1/<string:img_name>", methods=["POST"])
def classify_image(img_name):

    # First the image has to be uploaded to the UPLOAD_DIRECTORY

    image = open_image(UPLOAD_DIRECTORY + img_name)

    classes = ["Cardboard", "Glass", "Metal", "Paper", "Plastic"]

    pred_class, pred_idx, outputs = model.predict(image)


    return jsonify({"object_detected": classes[pred_idx],
                    "confidence": "%.3f" % outputs[pred_idx]})


# ======== Main ============================================================== #
if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True, use_reloader=True)
