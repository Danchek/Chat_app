$(function() {
    $('#pictureInput').on('change', function(event) {
        var files = event.target.files;
        var image = files[0];
        var reader = new FileReader();
        reader.onload = function(file) {
            var img = new Image();
            img.src = file.target.result;
            img.style.height = '320px';
            img.style.width = '320px';
            $('#target').html(img);
        };
        reader.readAsDataURL(image);
    });
});
