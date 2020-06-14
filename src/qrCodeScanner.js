const qrcode = window.qrcode;

const video = document.createElement("video");
const canvasElement = document.getElementById("qr-canvas");
const canvas = canvasElement.getContext("2d");

const qrResult = document.getElementById("qr-result");
const btnScanQR = document.getElementById("btn-scan-qr");
const txt_search = document.getElementById("txt_search");
const txt_status = document.getElementById("txt_status");
const txt_ply_id = document.getElementById("txt_ply_id");
const txt_ply_first_name = document.getElementById("txt_ply_first_name");
const txt_ply_last_name = document.getElementById("txt_ply_last_name");
const txt_ply_email = document.getElementById("txt_ply_email");
const txt_ply_height = document.getElementById("txt_ply_height");
const txt_ply_birthdate = document.getElementById("txt_ply_birthdate");
const img_ply_picture = document.getElementById("img_ply_picture");

let scanning = false;

qrcode.callback = res => {
  if (res) {
    txt_search.value = res;
    txt_status.value = "Press button to search in database";
    txt_status.className = "disabledinput";
    txt_ply_id.value = "";
    txt_ply_first_name.value = "";
    txt_ply_last_name.value = "";
    txt_ply_email.value = "";
    txt_ply_height.value = "";
    txt_ply_birthdate.value = "";
    img_ply_picture.src =
      "https://alanferrandiz.files.wordpress.com/2020/06/ply_0.jpg";

    scanning = false;
    video.srcObject.getTracks().forEach(track => {
      track.stop();
    });

    qrResult.hidden = false;
    canvasElement.hidden = true;
    btnScanQR.hidden = false;
  }
};

btnScanQR.onclick = () => {
  navigator.mediaDevices
    .getUserMedia({ video: { facingMode: "environment" } })
    .then(function(stream) {
      scanning = true;
      qrResult.hidden = true;
      btnScanQR.hidden = true;
      canvasElement.hidden = false;
      video.setAttribute("playsinline", true); // required to tell iOS safari we don't want fullscreen
      video.srcObject = stream;
      video.play();
      tick();
      scan();
    });
};

function tick() {
  canvasElement.height = video.videoHeight;
  canvasElement.width = video.videoWidth;
  canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);

  scanning && requestAnimationFrame(tick);
}

function scan() {
  try {
    qrcode.decode();
  } catch (e) {
    setTimeout(scan, 300);
  }
}
