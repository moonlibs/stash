if not package.path:match('^../') then package.path = '../?.lua;'..package.path end
require 'package.reload'

box.cfg{}

local m = require 'module'
print("Module = ",m)

if not require'fiber'.self().storage.console then
	require'console'.start()
	os.exit()
end
