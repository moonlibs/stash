package = 'stash'
version = 'scm-1'
source  = {
    url    = 'git://github.com/moonlibs/stash.git',
    branch = 'master',
}
description = {
    summary  = "Keep data between code reloads",
    homepage = 'https://github.com/moonlibs/stash.git',
    license  = 'BSD',
}
dependencies = {
    'lua >= 5.1'
}
build = {
    type = 'builtin',
    modules = {
        ['stash'] = 'stash.lua'
    }
}

-- vim: syntax=lua
