document.addEventListener("DOMContentLoaded", function() {
  [].forEach.call(document.querySelectorAll(".dropimage"), function(img) {
    img.onchange = function(e) {
      var inputfile = this,
        reader = new FileReader();
      reader.onloadend = function() {
        inputfile.style["background-image"] = "url(" + reader.result + ")";
      };
      reader.readAsDataURL(e.target.files[0]);
    };
  });
});
