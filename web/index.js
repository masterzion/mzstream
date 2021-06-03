function setposy(val) {
  var cam = document.getElementById("camera");
  cam.style.marginTop = ((100-val)/1.77)+"%";
}


function setposx(val) {
  var cam = document.getElementById("camera");
  cam.style.marginLeft = val/1.33+"%";
}


function loadJSON(callback, filename) {
  var req = new XMLHttpRequest();
//  req.responseType = 'json';
  req.open('GET', filename, true);
  req.onload  = function() {
    callback(req.responseText);
  };

  req.send(null);
}


function LoadDrivers(response) {
   var actual_JSON = JSON.parse(response);

   var video1 = document.getElementById("video1");
   var video2 = document.getElementById("video2");
   var audio = document.getElementById("audio");


   Object.keys(actual_JSON.video).forEach(function(value,i){
      var txt = actual_JSON.video[value];
      if (txt.slice(-2) != '()') {
        var option1 = document.createElement("option");
        var option2 = document.createElement("option");
        option1.value = value;
        option1.text = txt;

        option2.value = value;
        option2.text = txt;

        try {
            video1.options.add(option1);
            video2.options.add(option2);
        }
        catch (e) {
            alert(e);
        }
      }
   });

   Object.keys(actual_JSON.audio).forEach(function(n,i){
      var v = actual_JSON.audio[n];
      var option1 = document.createElement("option");
      option1.text = v;
      option1.value = n;

      try {
          audio.options.add(option1);
      }
      catch (e) {
          alert(e);
      }
   });


}



function init() {
  loadJSON(LoadDrivers, 'drivers.json');
  setposy(100);
  setposx(100);
}
