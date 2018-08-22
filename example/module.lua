-- get stash by module name from `...'
local stash = require 'stash' (...)
local log = require 'log'

stash.run = ( stash.run or 0 ) + 1

print("It's run",stash.run,"from stash",stash)

return {}