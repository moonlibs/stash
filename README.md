# Stash
### Tool for keeping data across code reloads

There are several techniques for keeping data across code reloads.
(Code reload - cleaning up `package.loaded[<module name>]` with following `require '<module name>'`)


1. Store value in global

```lua
local data
if not MY_DATA then
    MY_DATA = {}
end
local data = MY_DATA
```

* May not work under strict
* Suffers from possibility to override it from somewhere

2. Store value in _G using `rawget`/`rawset`

```lua
local data
if not rawget(_G,'MY_DATA') then
    rawset('MY_DATA',{})
end
local data = MY_DATA
```

* Suffers from possibility to override it from somewhere

3. Store value in _G using `rawget`/`rawset` and give it unwritable name (use `\0` for example)

```lua
local data
if not rawget(_G,'\0MY_DATA') then
    rawset('\0MY_DATA',{})
end
local data = rawget(_G,'\0MY_DATA')
```

This will work rather good and this technique is used by `stash`. But using this from a lot modules will cause _G pollution

So, for easy use the `stash` was created.

Simple interface allows to get the same stash by name

```lua
local mystash = require'stash'.get('stash name')
```

Or with use of overloaded call

```lua
local mystash = require'stash'('stash name')
```

From within module, name of module in `...` may be used as name without collision with _G

```lua
local mystash = require'stash'(...)
```

There are also 2 more methods:

```lua
require'stash'.del('stash name') -- to delete some stash
require'stash'.clear('stash name') -- to empty some stash
```




