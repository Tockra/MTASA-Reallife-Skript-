	bindKey("ralt","both",
 	function(key,state)
		if(state == "up") then
			showCursor( false )
		else
			showCursor( true )
		end
  	end)
