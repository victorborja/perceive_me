function initPerson() {

  var cam = $('#my_camera');

  if (cam.length > 0) {
    Webcam.attach(cam.get(0));

    function take_snapshot() {
      Webcam.snap(function(data_uri) {
        $('#my_photo').html( $('<img>', {src: data_uri}) );
        $('input[name="person[snap]"]').val(data_uri);
      });
    }
    $('#smile').click(take_snapshot);
  }


}

$(document).ready(initPerson);

