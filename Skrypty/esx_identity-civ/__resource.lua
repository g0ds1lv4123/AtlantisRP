version '1.0.2'

client_script('client.lua')

server_script "@mysql-async/lib/MySQL.lua"
server_script "server.lua"

ui_page('html/index.html')

files({
  
  'html/index.html',
  'html/bootstrap.min.css',
  'html/bootstrap-extend.css',
  'html/master_style.css',
  'html/master_style_dark.css',
  'html/master_style_rtl.css',
  'html/images/bg.jpg',
  'html/images/bg1.jpg',
  'html/images/bg2.jpg',
  'html/js/jquery-3.3.1.js',
})

exports {
  'openRegistry'
}