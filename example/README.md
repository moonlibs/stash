# Usage for Tarantoo∞l

Consider creating app `init.lua`, use `package.reload` (or analogue) for reloading and suppose app is using `module.lua` for its purposes

```lua
require 'package.reload'
box.cfg{}

local m = require 'module'
print("Module = ",m)

```

Then assume, that `module` requires to persist some data across reloads (value `run`)

```lua
-- get stash by module name from `...'
local stash = require 'stash' (...)
-- equivalent to:
-- local stash = require 'stash'.get('module')

stash.run = ( stash.run or 0 ) + 1

print("It's run",stash.run,"from stash",stash)

return {}
```

Then run and test (unimportant logs are skipped)

```
$ tarantool init.lua
main/101/init.lua I> 1st load.
It's run    1   from stash  table: 0x0106e83278
Module =    table: 0x0106e84740
>
```

Now, call to reload

```
> package.reload()
main/101/init.lua I> 2nd load. Unloading {stash, module}
It's run    2   from stash  table: 0x0106e83278
Module =    table: 0x0106297fc0

> package.reload()
main/101/init.lua I> 3rd load. Unloading {stash, module}
It's run    3   from stash  table: 0x0106e83278
Module =    table: 0x0106266458
```

`module` was reloaded but stash for it remains the same
