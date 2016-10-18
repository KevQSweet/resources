description 'localchat'

ui_page 'html/chat.html'

client_script 'localchat_client.lua'
server_script 'localchat_server.lua'

export 'printChatLine'

files {
    'html/chat.html',
    'html/chat.css',
    'html/chat.js',
    'html/jquery.faketextbox.js'
}
