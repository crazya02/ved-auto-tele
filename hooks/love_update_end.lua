if state == 1 then for _,v in pairs(scriptnames) do
	if string.match(v, '^t%d+%D%d+$') ~= nil then --Is this a teleport script?
		--Yep! Load the script without opening the script editor
		scriptname = v
		scriptlines = table.copy(scripts[scriptname])
		processflaglabels()
		if scriptlines[1] == "" and scriptlines[2] == nil then --Is it empty?
			--It is! Grab the coordinates from the string.
			telex = tonumber(string.sub(string.match(v, 't%d+%D'), 2, -2))
			teley = tonumber(string.sub(string.match(v, '%D%d+$'), 2, -1))

			--Display debug text
			successfulDoink = true

			--Write script lines and save the script back to the level data
			teleScriptName = "t" .. telex .. "_" .. teley .. "b"
			scriptlines[1] = "iftrinkets(0," .. teleScriptName .. ")"
			scripts[scriptname] = table.copy(scriptlines)

			--Now to create the internal script!
			scriptname = teleScriptName
			table.insert(scriptnames, teleScriptName)
			editingline = 1
			scriptlines[1] = "gotoroom(" .. (telex - 1) .. "," .. (teley - 1) .. ")"
			internalscript = true
			scripts[teleScriptName] = table.copy(scriptlines)
			processflaglabelsreverse()
		end
	end
end end
