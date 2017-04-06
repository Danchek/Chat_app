$(document).ready(function () {

    get_friends();

    function add_friend() {
        $('.add_user_btn').click(function () {
            $.ajax({
                type: "PATCH",
                url: '',
                data: ''
            }).success(function (html) {

            });

        });
    }

    function get_friends() {
        $('#modal_btn').click(function () {
            var dataId = {'id': $(this).attr('data-id').toString()}
            $.ajax({
                type: "GET",
                url: '/friends/for_chat',
                data: dataId
            }).success(function (html) {
                $('#chat_modal_body').html(html);
                add_friend();
            });
        });
    }
});
