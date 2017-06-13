jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
      channel: "ChatRoomsChannel"
      chat_room_id: messages.data('chat-room-id')
    },
      connected: ->
# Called when the subscription is ready for use on the server

      disconnected: ->
# Called when the subscription has been terminated by the server

      received: (data) ->
        if data['action'] == 'edit'
          message_body = $('#message_body')
          message_body.val(data['edit_body'])
          message_body.addClass('update_message')
          document.querySelector('#message_body').dataset.messageId = data['id']
        else if data['action'] == 'post'
          messages.append data['message']
        else if data['action'] == 'update'
          document.getElementById('message_'+data['id']).innerHTML = data['update_body']
        else if data['action'] == 'delete'
          document.getElementById('message_block_'+data['id']).remove()
        messages_to_bottom()
        editHandler()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

      edit_message: (message_id) ->
        @perform 'edit_message', message_id: message_id

      update_message: (message_id, message) ->
        @perform 'update_message', message_id: message_id, message: message

      delete_message: (message_id) ->
        @perform 'delete_message', message_id: message_id

    editHandler = ->
      $('.button_edit').click (e) ->
        App.global_chat.edit_message $(this).data('messageId')
        e.preventDefault()
        return false

    $('.button_delete').click (e) ->
      App.global_chat.delete_message $(this).data('messageId')
      e.preventDefault()
      return false

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        if textarea.hasClass('update_message')
          App.global_chat.update_message textarea.data('messageId'), textarea.val()
        else
          App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false

    editHandler()
