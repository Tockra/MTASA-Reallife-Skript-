local function dataChange ( data, value )
	if client and data ~= "DutyLock" then
		setElementData ( source, data, value )
	end
end
addEventHandler ( "onElementDataChange", getRootElement(), dataChange )

