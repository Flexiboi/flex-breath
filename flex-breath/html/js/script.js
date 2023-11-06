var amount = 0;
var totalamount = 0;

window.addEventListener('message', function(event) {
    const data = event.data;
    if(data.display) {
      if(data.amount){
        amount = Math.random(0.01,0.5);
        totalamount = amount * (data.amount/100);
        document.getElementById("breath").innerHTML = '<p>'+parseFloat(totalamount.toFixed(2))+'</p>';
      }
      $("#container").fadeIn(350);
    }
});

$( function() {
    $("body").on("keydown", function (key) {
        if (key.keyCode == 27) {
            close();
        }
    });
});

$(document).on('click', '#start', function(e){
    e.preventDefault();
    if(amount == 0 && totalamount == 0){
        $.post('https://flex-breath/StartBreath', JSON.stringify({}));
    }
});

$(document).on('click', '#reset', function(e){
    e.preventDefault();
    amount = 0;
    totalamount = 0;
    document.getElementById("breath").innerHTML = '';
});


function close() {
    $("#container").fadeOut(350);
    $.post("https://flex-breath/CloseNui", JSON.stringify({}));
}

//DRAG

dragElement(document.getElementById("container"));
function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
  if (document.getElementById(elmnt.id + "header")) {
    // if present, the header is where you move the DIV from:
    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
  } else {
    // otherwise, move the DIV from anywhere inside the DIV:
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
  }
}