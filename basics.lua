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

  url = args.url -- get the url from input area
  assert(splash:go(url)) -- open the url in splash
  assert(splash:wait(1)) -- wait 1 min to javascript to fully render (optional but needed) 
  
  input_box = splash:select("div .gLFyf") -- selecting required element through css selector
  input_box:focus() 
  input_box:send_text('my user agent') -- send text into input
  assert(splash:wait(1)) 
  input_box:send_keys("<Enter>") -- emulating keyboard event
  
  -- search_button = assert(splash:select(".FPdoLc center .gNO89b"))
  -- search_button:mouse_click() -- clicking mouse
  assert(splash:wait(4))
  
  splash:set_viewport_full() -- veiws the full extent of the page

  -- returning a class with required attribute
  return {
    image = splash:png(), -- captures screenshot of the web page
    src = splash:html(), -- raw html
  }
end
