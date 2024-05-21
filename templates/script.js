function displaySelectedImage(event) {
    let predictionResult = document.getElementById(
        "predictionResult"
      );
      predictionResult.textContent='';
    var selectedImage = document.getElementById('selected-image');
    selectedImage.src = URL.createObjectURL(event.target.files[0]);
    selectedImage.style.display = 'block';
}
function predictClass() {
    var formData = new FormData();
    var fileInput = document.getElementById("fileInput");
    var file = fileInput.files[0];
    formData.append("file", file);
  
    if (file) {
      fetch("http://127.0.0.1:8080/testing", {
        method: "POST",
        body: formData,
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          let predictionResult = document.getElementById(
              "predictionResult"
            );
            predictionResult.textContent=data.prediction_class;
        }).catch((error)=>{
          console.log(error)
        });
    }
    else{
      alert("Please Upload an Image First");
    }
  }