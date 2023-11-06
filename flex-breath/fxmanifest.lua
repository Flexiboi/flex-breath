fx_version 'cerulean'
game 'gta5'

description 'flex-breath'
version '1.0.0'
this_is_a_map 'yes'

ui_page('html/index.html') 

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/nl.lua',
}

client_scripts {
    'config.lua',
    'client/main.lua',
}

server_scripts {
    'config.lua',
    'server/main.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
    'html/audio/pling.mp3',
    'html/img/*.png',
    -- 'prop_breath.ydr',
    -- 'prop_breath.ytyp'
}

-- data_file 'DLC_ITYP_REQUEST' 'prop_breath.ydr'
-- data_file 'DLC_ITYP_REQUEST' 'prop_breath.ytyp'