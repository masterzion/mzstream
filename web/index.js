
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
  req.open('GET', filename, true);
  req.setRequestHeader("Cache-Control", "no-cache, no-store, max-age=0");
  req.onreadystatechange = function() {
        if (this.readyState == 4)
          if (this.status == 200) {
              callback(req.responseText);
          } else {
            console.log(this.status)
            setTimeout(function(){
              loadJSON(callback, filename);
            }, 1*1000, "1")
          }
      };

  try {
      req.send(null);
  } catch (e) {
    console.log(e);
  }

}


function LoadDrivers(response) {
   var actual_JSON = JSON.parse(response);

   var video1 = document.getElementById("video1");
   var video2 = document.getElementById("video2");
   var audio = document.getElementById("audio");
   var run = document.getElementById("run");


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
            console.log(e);
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
          console.log(e);
      }
   });

   video1.disabled=false;
   video2.disabled=false;
   audio.disabled=false;
   run.disabled=false;

}

function senddata(enabled) {
   var val_y = document.getElementById("val_y").value;
   var val_x = document.getElementById("val_x").value;
}

function refreshdata() {
  video1.innerHTML = "";
  video2.innerHTML = "";
  audio.innerHTML = "";

  video1.disabled=true;
  video2.disabled=true;
  audio.disabled=true;
  run.disabled=true;


  loadJSON(LoadDrivers, 'drivers.json');
}

function init() {
  setposy(100);
  setposx(100);
  refreshdata();
}
