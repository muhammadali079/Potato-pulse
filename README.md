# POTATO DISEASE DETECTION
In the agricultural sector, potato crops play a crucial role in global food security and economy. However, potato blight, encompassing both early and late blight diseases, poses a significant threat to potato yield and quality. Early detection and accurate classification of these diseases are paramount in mitigating losses and implementing effective management strategies. "Potato Pulses" aims to address this challenge by leveraging artificial intelligence to analyze potato leaf images, thereby enabling the identification of healthy leaves and the differentiation between early and late blight diseases. This project not only contributes to safeguarding potato crops but also supports farmers in taking timely actions to protect their yield.

### **Importance of the Project**
The importance of this project stems from its potential to transform the traditional approach to disease management in potato farming. By providing a quick and accurate diagnosis tool, the project facilitates early intervention, which is critical for controlling the spread of blight diseases. Additionally, this AI-based solution offers a scalable and cost-effective alternative to labor-intensive and subjective traditional methods, ultimately enhancing productivity and sustainability in potato farming.

### **Dataset**
The dataset consists of high-quality images of potato leaves, categorized into three groups: healthy, early blight, and late blight. Each image is labeled according to its disease state, serving as the foundation for training and evaluating the AI model.
for more info goto [Dataset-info](Data Training/Documentation.txt)

### **Preprocessing Steps**
**Image Cleaning:** Removal of irrelevant content from images, such as background noise and unrelated objects, to focus on the leaf itself.

**Normalization**: Standardization of image dimensions and color intensities to ensure uniformity across the dataset, enhancing the model's ability to learn from the data.

**Augmentation:** Application of various transformations like rotation, flipping, and scaling to increase the dataset's diversity. This step helps improve the model's robustness and ability to generalize from the training data to real-world scenarios.

**Splitting:** Division of the dataset into training, validation, and test sets. This separation is critical for training the model, tuning its parameters, and evaluating its performance accurately.

By clearly defining the problem, emphasizing the project's significance, and outlining a meticulous approach to data preparation, "Potato Pulses" is positioned as a crucial innovation in combating potato blight diseases through the application of AI.

### ***Setup for Python:***

1. Install Python [Setup Guide](https://wiki.python.org/moin/BeginnersGuide)

2. Install Python packages

3. To install dependencies for training, run:

```
pip3 install -r training/requirements.txt
```
4. To install dependencies for the API, run:
```
pip3 install -r api/requirements.txt
```
5. Install Tensorflow Service [Setup Guide](https://www.tensorflow.org/tfx/serving/setup)


### ***Setup for ReactJS:***

1. Install Nodejs [Setup Guide](https://nodejs.org/en/download/package-manager/)
   
2. Install NPM [Setup Guide](https://docs.npmjs.com/getting-started)

3. Install dependencies
```
cd frontend
npm install --from-lock-json
npm audit fix
```
4. Copy `.env.example` as `.env.`

5. Change API url in `.env.`


### ***Setup for React-Native app:***
1. Go to the [React Native environment setup](https://reactnative.dev/docs/environment-setup), then select `React Native CLI Quickstart` tab.

2. Install dependencies
   ```
   cd mobile-app
   yarn install
   ```
3. Copy `.env.example` as `.env`.

4. Change API url in `.env`.

### ***Training the Model:***
1. Download the data from [kaggle](https://www.kaggle.com/datasets/arjuntejaswi/plant-village).
2. Only keep folders related to Potatoes.
3. Run Jupyter Notebook in Browser.
`jupyter notebook`
4. Open `training/potato-disease-training.ipynb` in Jupyter Notebook.
5. In cell #2, update the path to dataset.
6. Run all the Cells one by one.
7. Copy the model generated and save it with the version number in the `models` folder.

### ***Running the API:***
**Using FastAPI**
1. Get inside `api` folder
```
cd api
```
2. Run the FastAPI Server using uvicorn
 ```
uvicorn main:app --reload --host 0.0.0.0
```
4. Your API is now running at `0.0.0.0:8000`


### ***Creating the TF Lite Model:***
1. Run Jupyter Notebook in Browser.
```
jupyter notebook
```
2. Open `training/tf-lite-converter.ipynb` in Jupyter Notebook.
3. In cell #2, update the path to dataset.
4. Run all the Cells one by one.
5. Model would be saved in `tf-lite-models` folder.


### ***Mobile-Application ScreenShot***

![Potato-pulse](potato-pulse-mob-app-s.s.jpeg)

![Potatopulse](Screenshot (235).png)
