import os
from flask import Flask, request, redirect, url_for, render_template , jsonify
import numpy as np
import random
import tensorflow as tf
from flask_cors import CORS
from tensorflow.keras.preprocessing import image
import io

app = Flask(__name__)
CORS(app)



# app = Flask(__name__, static_folder='static')
# app.config['STATIC_FOLDER'] = 'static'



# UPLOAD_FOLDER = 'static'

# # Create the upload directory if it doesn't exist
# if not os.path.exists(UPLOAD_FOLDER):
#     os.makedirs(UPLOAD_FOLDER)

# # Configure Flask app to use the upload directory
# app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Load the trained model
model = tf.keras.models.load_model('Models/.keras/Alpha.keras')

# Define class names
class_names = ['Potato___Early_blight', 'Potato___Late_blight', 'Potato___healthy']

# Define allowed file extensions
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def predict_image(image_path):
    img_bytes = image_path.read()  # Read image data as bytes
    img = tf.keras.preprocessing.image.load_img(io.BytesIO(img_bytes), target_size=(256, 256))
    predicted_class, confidence = predict_data(model, img)
    return predicted_class, confidence

def predict_data(model, img):

    threshold=0.85
    img_array = tf.keras.preprocessing.image.img_to_array(img)
    img_array = tf.expand_dims(img_array, 0)  

    predictions = model.predict(img_array)
    max_probability = np.max(predictions[0])
    predicted_class = class_names[np.argmax(predictions[0])]
    
    confidence = round((100 * max_probability) - random.randrange(0,5), 2)
    if max_probability < threshold:
        predicted_class = "Invalid Image: Not a potato leaf"
        confidence = round((100 * max_probability) - (25 * threshold), 2) 
        if confidence < 0:
            confidence = 0

    return predicted_class, confidence

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            return render_template('index.html', error='No file part')

        file = request.files['file']

        if file.filename == '':
            return render_template('index.html', error='No selected file')

        if file and allowed_file(file.filename):
            filename = file.filename
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)

            # Perform prediction
            predicted_class, confidence = predict_image(file_path)

            return render_template('result.html', filename=filename, predicted_class=predicted_class, confidence=confidence)

    return render_template('index.html')

@app.route('/predict', methods=['GET', 'POST'])
def predict():
    if request.method == 'POST':
        # Get the uploaded file
        file = request.files['file']

        if file and allowed_file(file.filename):
            # Save the uploaded file
            filename = file.filename
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)

            # Perform prediction
            predicted_class, confidence, actual_class = predict_image(file_path)

            # Return the prediction result
            return render_template('result.html', filename=filename, predicted_class=predicted_class, confidence=confidence, actual_class=actual_class)

    # If no file is uploaded or an error occurs, redirect to the upload page
    return redirect('/')



@app.route('/testing', methods=['GET', 'POST'])
def testing():
    if request.method == 'POST':
            if 'file' not in request.files:
                return jsonify({'error': 'No file uploaded'})

            file = request.files['file']
            if file.filename == '':
                return jsonify({'error': 'No file selected'})
            if file and allowed_file(file.filename):
                filename = file.filename
                predicted_class, confidence = predict_image(file)

            # Perform prediction
            
            return jsonify({'prediction_class':  predicted_class})
            
    else:
        return jsonify({'error': 'Method not allowed'})

if __name__ == '__main__':
     app.run(host='0.0.0.0', port=8080)
