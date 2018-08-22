local stash = require 'stash'

local my_stash = stash.get('module.stash.name')

-- ...
-- imitate reload
package.loaded['stash'] = nil
local stash = require 'stash'

local other_stash = stash.get('module.stash.name')

assert(other_stash == my_stash, "Stashes are the same")