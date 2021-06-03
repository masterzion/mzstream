current_config = {
    "audio" : "",
    "capture" : "",
    "webcam": "",
    "val_x" : "",
    "val_y" : ""
}

is_running=0

function setposy(val) {
  var cam = document.getElementById("camera");
  cam.style.marginTop = ((100-val)/1.77)+"%";
}


function setposx(val) {
  var cam = document.getElementById("camera");
  cam.style.marginLeft = val/1.33+"%";
}


function loadJSON(callback, filename, forceretry) {
  var req = new XMLHttpRequest();
  req.open('GET', filename, true);
  req.setRequestHeader("Cache-Control", "no-cache, no-store, max-age=0");
  req.onreadystatechange = function() {
        if (this.readyState == 4)
          if (this.status == 200) {
              callback(req.responseText);
          } else {
            console.log(this.status)
            if ( forceretry ) {
              setTimeout(function(){
                loadJSON(callback, filename);
              }, 1*1000, "1");
            }
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

   setposy(current_config.val_y);
   document.getElementById("val_y").value = current_config.val_y;

   setposx(current_config.val_x);
   document.getElementById("val_x").value = current_config.val_x;

   document.getElementById("run").checked = is_running;



   cur_index = 0;
   Object.keys(actual_JSON.video).forEach(function(value,i){
      var txt = actual_JSON.video[value];

      if (txt.slice(-2) != '()') {
        var option1 = document.createElement("option");
        option1.value = value;
        option1.text = txt;

        video1.options.add(option1);

        if (txt == current_config.capture) {
          video1.selectedIndex = cur_index;
        }



        var option2 = document.createElement("option");
        option2.value = value;
        option2.text = txt;
        video2.options.add(option2);
        if (txt == current_config.webcam) {
          video2.selectedIndex = cur_index;
        }
       cur_index++;

      }
   });

   Object.keys(actual_JSON.audio).forEach(function(value,i){
      var txt = actual_JSON.audio[value];
      var option1 = document.createElement("option");
      selected=(txt == current_config.webcam);

      option1.text = txt;
      option1.value = value;

      audio.options.add(option1);
      if (txt == current_config.audio) {
        audio.selectedIndex = i;
      }

   });

   video1.disabled=is_running;
   video2.disabled=is_running;
   audio.disabled=is_running;
   run.disabled=false;

}

function LoadConfig(response) {
  current_config = JSON.parse(response);
}


function LoadRunning(response) {
  var video1 = document.getElementById("video1");
  var video2 = document.getElementById("video2");
  var audio = document.getElementById("audio");

  var val_y = document.getElementById("val_y");
  var val_x = document.getElementById("val_x");

  is_running = 0;

  val_y.disabled=is_running;
  val_x.disabled=is_running;

  video1.disabled=is_running;
  video2.disabled=is_running;
  audio.disabled=is_running;
  is_running = JSON.parse(response);

  val_y.disabled=is_running;
  val_x.disabled=is_running;

  video1.disabled=is_running;
  video2.disabled=is_running;
  audio.disabled=is_running;
}






function senddata(enabled) {
  var xmlhttp = new XMLHttpRequest();

  var video1 = document.getElementById("video1");
  var video2 = document.getElementById("video2");
  var audio = document.getElementById("audio");

  var val_y = document.getElementById("val_y");
  var val_x = document.getElementById("val_x");


  if (enabled) {
      data = {
      "audio" : audio.options[video1.selectedIndex].innerHTML,
      "audio_id" : audio.options[video1.selectedIndex].value,
      "capture" : video1.options[video1.selectedIndex].innerHTML,
      "capture_id" : video1.options[video1.selectedIndex].value,
      "webcam":   video2.options[video2.selectedIndex].innerHTML,
      "webcam_id":   video2.options[video2.selectedIndex].value,
      "val_x" : val_x.value,
      "val_y" : val_y.value,
      }
      url="/run";
      is_running=true;
  } else {
    url="/stop";
    data = 0;
    is_running=false;
  }

  val_y.disabled=is_running;
  val_x.disabled=is_running;

  video1.disabled=is_running;
  video2.disabled=is_running;
  audio.disabled=is_running;

  xmlhttp.open("POST", url);
  xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xmlhttp.send(JSON.stringify(data));
}

function refreshdata() {
  video1.innerHTML = "";
  video2.innerHTML = "";
  audio.innerHTML = "";

  video1.disabled=true;
  video2.disabled=true;
  audio.disabled=true;
  run.disabled=true;

  loadJSON(LoadRunning, 'run.txt', false);
  loadJSON(LoadConfig, 'config.json', false);
  setTimeout(function(){
    loadJSON(LoadDrivers, 'drivers.json', true);
  }, 1*500, "1");

}

function init() {
  setposy(100);
  setposx(100);
  refreshdata();
}
