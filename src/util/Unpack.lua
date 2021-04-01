function _unpack(parent, table)
	for _, child in next, parent:GetChildren() do
		if (child.ClassName == "ModuleScript") then
			table[child.Name] = require(child)
		elseif (child.ClassName == "Folder") then
			table[child.Name] = {}
			_unpack(child, table[child.Name])
		end
	end
end

return _unpack
