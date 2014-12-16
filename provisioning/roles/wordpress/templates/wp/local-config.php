<?php
// ** MySQL settings ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wpe_{{ enviro }}');

/** MySQL database username */
define('DB_USER', 'wpe_{{ enviro }}');

/** MySQL database password */
define('DB_PASSWORD', 'wordpress');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', false);
define('SCRIPT_DEBUG', true);
define('SAVEQUERIES', true);

define('WP_CACHE_KEY_SALT', 'wpe_{{ enviro }}_1');

global $memecached_servers;

$memcached_servers = array(
    'default' => array(
        '127.0.0.1:11211'
    )
);
