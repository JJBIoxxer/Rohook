function readdir(parent, table)
	for _, child in next, parent:GetChildren() do
		if (child.ClassName == "ModuleScript") then
			table[child.Name] = require(child)
		elseif (child.ClassName == "Folder") then
			table[child.Name] = {}
			readdir(child, table[child.Name])
		end
	end
end

return readdir