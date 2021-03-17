function main(splash, args)
  -- Method 1 to change user agent
  -- splash:set_user_agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36")\
  
  --[[ 
  -- Method 2 to change user agent
  headers = {
    ["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36"
  }
  splash:set_custom_headers(headers) 
  --]]
  
  -- Method 3 for header spoofing
  splash:on_request(
    function(request)
      assert(request:set_header('User-Agent', "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36"))
    end
    )
  
  url = args.url
  assert(splash:go(url))
  assert(splash:wait(1))
  
  input_box = splash:select("div .gLFyf")
  input_box:focus()
  input_box:send_text('my user agent')
  assert(splash:wait(1))
  input_box:send_keys("<Enter>")
  
  -- search_button = assert(splash:select(".FPdoLc center .gNO89b"))
  -- search_button:mouse_click()
  assert(splash:wait(4))
  
  splash:set_viewport_full()
  
  return {
    image = splash:png(),
    src = splash:html(),
  }
end
