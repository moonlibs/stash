local M = {}
local HIDDEN_MT = { __serialize = function() return end }
local STASH_MT = { __serialize = function() return '...' end }
if not rawget(_G,'\0STASH') then
	M.stash = setmetatable({},HIDDEN_MT)
	rawset(_G,'\0STASH', M.stash)
else
	M.stash = rawget(_G,'\0STASH')
end

if not table.clear then
	table.clear = function(t)
		if type(t) ~= 'table' then
			error("bad argument #1 to 'clear' (table expected, got "..(t ~= nil and type(t) or 'no value')..")",2)
		end
		for k in pairs(t) do t[k]=nil end
		return
	end
end

function M.get( name )
	if not M.stash[ name ] then
		M.stash[ name ] = setmetatable({},STASH_MT)
	end
	return M.stash[ name ]
end

function M.del( name )
	M.stash[ name ] = nil
	return
end
M.remove = M.del

function M.clear( name )
	if M.stash[ name ] then
		table.clear(M.stash[ name ])
	end
	return
end

setmetatable(M,{
	__call = function( self, name )
		return self.get(name)
	end
})

return M
