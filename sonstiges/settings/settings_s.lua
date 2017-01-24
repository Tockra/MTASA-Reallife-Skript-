local function onResourceStart(res)
	if(res ~= getThisResource()) then
		return 0
	end
	setGameType("Unlimited Reallife")
	setMapName("Los Santos")

	
	local result = mysql_query(Datenbank, "SELECT * FROM `settings`")
	if(mysql_num_rows(result) ~= 0) then
		for result,row in mysql_rows_assoc(result) do
			setData(getRootElement(),"Settings",tostring(row["Setting"]),tonumber(row["Set"]),false)
		end
		mysql_free_result(result)
	else
		mysql_free_result(result)
	end
end
addEventHandler("onResourceStart",getRootElement(),onResourceStart)