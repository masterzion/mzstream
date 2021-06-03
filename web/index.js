function setposy(val) {
  var y = parseInt(val / 768  * 100);
  var cam = document.querySelector('#camera');

  console.log(y);

  cam.style.padding-top = y;
}


function setposx(val) {
  var x = parseInt(val / 1024 * 100);
  var cam = document.querySelector('#camera');
  console.log(x);
  cam.style.padding-left = x;
}
