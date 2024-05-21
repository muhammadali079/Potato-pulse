import os
from flask import Flask, request, render_template
import numpy as np
import tensorflow as tf

app = Flask(__name__, static_folder='static')
app.config['STATIC_FOLDER'] = 'static'

UPLOAD_FOLDER = 'static'

# Create the upload directory if it doesn't exist
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# Configure Flask app to use the upload directory
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Load the trained model
model = tf.keras.models.load_model('../Models/.keras/Alpha.keras')

# Define class names
class_names = ['Potato___Early_blight', 'Potato___Late_blight', 'Potato___healthy']

# Define allowed file extensions
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def predict_image(image_path):
    img = tf.keras.preprocessing.image.load_img(image_path, target_size=(256, 256))
    predicted_class, confidence = predict_data(model, img)
    filename = os.path.basename(image_path)
    return predicted_class, confidence, filename

def predict_data(model, img):
    img_array = tf.keras.preprocessing.image.img_to_array(img)
    img_array = tf.expand_dims(img_array, 0)
    predictions = model.predict(img_array)
    predicted_class = class_names[np.argmax(predictions[0])]
    confidence = round(100 * np.max(predictions[0]), 2)
    return predicted_class, confidence

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return 'No file part'

    file = request.files['file']

    if file.filename == '':
        return 'No selected file'

    if file and allowed_file(file.filename):
        filename = file.filename
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)

        # Perform prediction
        predicted_class, confidence, actual_class = predict_image(file_path)

        # Return the prediction result
        return render_template('result.html', filename=filename, predicted_class=predicted_class, confidence=confidence, actual_class=actual_class)

    return 'Invalid file format'

if __name__ == '__main__':
    app.run(debug=True)
