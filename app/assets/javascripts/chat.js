$(document).on('turbolinks:load', function() {

    get_friends();
    add_friend_to_chat();

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
            var dataId = {'id': $(this).attr('data-id').toString()};
            $.ajax({
                type: "GET",
                url: '/friends',
                data: dataId
            }).success(function (html) {
                $('#chat_modal_body').html(html);
                add_friend();
            });
        });
    }

    function add_friend_to_chat() {
        $('.add-friend-to-chat').submit(function () {
            var valuesToSubmit = $(this).serialize();
            $.ajax({
                type: "POST",
                url: $(this).attr('action'),
                data: valuesToSubmit,
                success: function (html) {
                    alert('Form has been sent successfully!');
                },
                error: function (json) {
                    alert('Please check all mandatory fields before submit form');
                }
            });
            return false; // prevents normal behaviour
        })
    }
});
