<?php
// $Id: art.profile


// Define the default WYSIWYG editor
define('art_EDITOR', 'ckeditor');

// Define the allowed filtered html tags
define('art_FILTERED_HTML', '<a> <img> <br> <em> <p> <strong> <cite> <sub> <sup> <span> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd> <pre> <address> <h2> <h3> <h4> <h5> <h6>');

// Define the "manager" role name
define('art_MANAGER_ROLE', 'manager');

// Define the default theme
define('art_THEME', 'cube');

// Define admin theme
define('art_THEME_ADMIN', 'rubik');


// Define the default frontpage
define('art_FRONTPAGE', 'node/1');

/**
 * Return an array of the modules to be enabled when this profile is installed.
 *
 * @return
 *   An array of modules to enable.
 */
function art_profile_modules() {
  $modules = array(
    // Default Drupal modules.
    'help', 'menu', 'dblog', 'path',
    
    // Chaos Tools
    'ctools', 'context', 'context_ui',
    
    // Views
    'views', 'views_ui', 'views_content',
    
    // CCK
    'content', 'content_permissions', 'fieldgroup', 'text', 'filefield', 'imagefield',
    'optionwidgets', 'link', 'filefield_meta', 'nodereference',
    
    // Date
    'date_api', 'date_timezone', 'date',  'date_popup', 'date_tools',
     
    // ImageAPI + ImageCache
    'imageapi', 'imagecache', 'imageapi_gd', 'imagecache_ui',
    
    // Rules
    'token', 'rules', 'rules_admin',
    
    // Editor
    'wysiwyg', 'better_formats',

    // Install Profile
    'install_profile_api', 'node_export',
    
    // Misc
    'admin_menu', 'auto_nodetitle', 'backup_migrate', 'formfilter', 'imce', 'imce_wysiwyg', 'jquery_update', 'login_destination', 'menutrails', 'jquery_ui', 'path_redirect', 'semanticviews', 'views_bulk_operations', 'diff', 'pathauto', 'vertical_tabs',
    
    // Strongarm
    'strongarm', 
    
    // Features
    'features',
    
  );

  return $modules;
}

/**
 * Return a description of the profile for the initial installation screen.
 *
 * @return
 *   An array with keys 'name' and 'description' describing this profile,
 *   and optional 'language' to override the language selection for
 *   language-specific profiles.
 */
function art_profile_details() {
  
  return array(
    'name' => 'Art Website',
    'description' => 'Artist Website.'
  );
}

/**
 * Return a list of tasks that this profile supports.
 *
 * @return
 *   A keyed array of tasks the profile will perform during
 *   the final stage. The keys of the array will be used internally,
 *   while the values will be displayed to the user in the installer
 *   task list.
 */
function art_profile_task_list() {
  global $conf;
  $conf['site_name'] = 'Art Website';
  
  return $tasks;

}

/**
 * Perform any final installation tasks for this profile.
 *
 * @param $task
 *   The current $task of the install system. When hook_profile_tasks()
 *   is first called, this is 'profile'.
 * @param $url
 *   Complete URL to be used for a link or form action on a custom page,
 *   if providing any, to allow the user to proceed with the installation.
 *
 * @return
 *   An optional HTML string to display to the user. Only used if you
 *   modify the $task, otherwise discarded.
 */
function art_profile_tasks(&$task, $url) {

  // Include the enabled modules
  install_include(art_profile_modules());
  
  // Use the file to make a node
  install_node_export_import_from_file('profiles/art/content/nodes.import.inc', array('status'=>1), $user, FALSE);

  art_build_directories();
  art_config_menu();
  art_config_roles();
  art_config_perms();
  art_config_filter();
  art_config_wysiwyg();
  art_config_theme();
  art_config_vars();
  art_cleanup();

  // Insert default user-defined node types into the database. For a complete
  // list of available node type attributes, refer to the node type API
  // documentation at: http://api.drupal.org/api/HEAD/function/hook_node_info.
  $types = array(
    array(
      'type' => 'page',
      'name' => st('Page'),
      'module' => 'node',
      'description' => st("A <em>page</em>, similar in form to a <em>story</em>, is a simple method for creating and displaying information that rarely changes, such as an \"About us\" section of a website. By default, a <em>page</em> entry does not allow visitor comments and is not featured on the site's initial home page."),
      'custom' => TRUE,
      'modified' => TRUE,
      'locked' => FALSE,
      'help' => '',
      'min_word_count' => '',
    ),
  );

  foreach ($types as $type) {
    $type = (object) _node_type_set_defaults($type);
    node_type_save($type);
  }

  // Default page to not be promoted and have comments disabled.
  variable_set('node_options_page', array('status'));
  variable_set('comment_page', COMMENT_NODE_DISABLED);

  // Don't display date and author information for page nodes by default.
  $theme_settings = variable_get('theme_settings', array());
  $theme_settings['toggle_node_info_page'] = FALSE;
  $theme_settings['default_logo'] = FALSE;
  variable_set('theme_settings', $theme_settings);

  // Set homepage
  variable_set('site_frontpage', 'node/1');

  // Set site_footer value.
  variable_set('site_footer', st('&copy; Copyright 2010 by Art. Art Website.  All rights reserved.'));

  // Update the menu router information.
  menu_rebuild();

}

/**
 * Create necessary directories
 */
function art_build_directories() {
  $dirs = array('ctools', 'ctools/css', 'imagecache', 'css', 'js');
  
  foreach ($dirs as $dir) {
    $dir = file_directory_path() . '/' . $dir;
    file_check_directory($dir, TRUE);
  }
}

/**
 * Configure menu
 */
function art_config_menu() {
  // Create additional primary menu items
  $items = array(
    array('link_path' => '<front>', 'link_title' => t('Home'), 'weight' => 0),
    array('link_path' => 'node/2', 'link_title' => t('About'), 'weight' => 6),
    array('link_path' => 'node/3', 'link_title' => t('Contact'), 'weight' => 8),
  );

  foreach ($items as $item) {
    $item += array(
      'mlid' => 0,
      'module' => 'menu',
      'has_children' => 0,
      'options' => array(
        'attributes' => array(
          'title' => '',
        ),
      ),
      'customized' => 1,
      'original_item' => array(
        'link_title' => '',
        'mlid' => 0,
        'plid' => 0,
        'menu_name' => 'primary-links',
        'weight' => 1,
        'link_path' => '',
        'options' => array(),
        'module' => 'menu',
        'expanded' => 0,
        'hidden' => 0,
        'has_children' => 0,
      ),
      'description' => '',
      'expanded' => 0,
      'parent' => 'primary-links:0',
      'hidden' => 0,
      'plid' => 0,
      'menu_name' => 'primary-links',
    );
    menu_link_save($item);
  }
}

/**
 * Configure input filters
 */
function art_config_filter() {
  // Force filter format and filter IDs
  // Necessary because Drupal doesn't use machine names for everything
  
  // Filtered HTML
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 1 WHERE ff.name = 'Filtered HTML'");
  db_query("UPDATE {filter_formats} SET format = 1 WHERE name = 'Filtered HTML'");
  
  // Full HTML
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 2 WHERE ff.name = 'Full HTML'");
  db_query("UPDATE {filter_formats} SET format = 2 WHERE name = 'Full HTML'");
  
  // PHP code
  db_query("UPDATE {filters} f INNER JOIN {filter_formats} ff ON f.format = ff.format SET f.format = 3 WHERE ff.name = 'PHP code'");
  db_query("UPDATE {filter_formats} SET format = 3 WHERE name = 'PHP code'");
    
  // Let cmanager role use Full HTML
  db_query("UPDATE {filter_formats} SET roles = ',3,' WHERE name = 'Full HTML'");
  
  // Set Full HTML as default format for manager role
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (3, 'node', 2, 1, -4)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (3, 'comment', 2, 1, -4)");
  db_query("INSERT INTO {better_formats_defaults} (rid, type, format, type_weight, weight)
    VALUES (3, 'block', 2, 1, -4)");
      
  // Add filters to the format
  db_query("INSERT INTO {filters} (format, module, delta, weight) VALUES (5, 'filter', 0, -10)");
  db_query("INSERT INTO {filters} (format, module, delta, weight) VALUES (5, 'filter', 2, -9)");
  
  // Adjust settings for the filter
  variable_set('filter_url_length_5', 60);
  variable_set('filter_html_5', 1);
  variable_set('filter_html_help_5', 0);
  variable_set('allowed_html_5', '');
  
  // Set allowed HTML tags for Filter HTML format
  variable_set('allowed_html_1', art_FILTERED_HTML);
}

/**
 * Configure wysiwyg
 */
function art_config_wysiwyg() {
  // Load external file containing editor settings
  include_once('art_editor.inc'); 
  
  // Add settings for 'Filtered HTML'
  $item = new stdClass;
  $item->format = 1;
  $item->editor = art_EDITOR;
  $item->settings = serialize(art_editor_settings('Filtered HTML'));
  drupal_write_record('wysiwyg', $item);
  
  // Add settings for 'Full HTML'
  $item = new stdClass;
  $item->format = 2;
  $item->editor = art_EDITOR;
  $item->settings = serialize(art_editor_settings('Full HTML'));
  drupal_write_record('wysiwyg', $item);
}


/**
 * Configure roles
 */
function art_config_roles() {
  // Make sure default roles are set right (just in case)
  db_query("UPDATE {role} SET rid = 1 WHERE name = 'anonymous user'");
  db_query("UPDATE {role} SET rid = 2 WHERE name = 'authenticated user'");
  
  // Add the "Manager" role
  db_query("INSERT INTO {role} (rid, name) VALUES (3, '%s')", t(art_MANAGER_ROLE));
    
  // Make sure first user is a "Manager"
  db_query("INSERT INTO {users_roles} (uid, rid) VALUES (1, 3)");
}


/**
 * Configure permissions
 * 
 * Avoid using Features because we expect these to be changed
 */
function art_config_perms() {
  // Load external permissions file
  include_once('art_perms.inc');
  
  $roles_data = array();
  
  // Fetch available roles
  $roles = db_query("SELECT * FROM {role}");
  
  // Set up roles data
  while ($role = db_fetch_object($roles)) {
    $roles_data[$role->name] = array(
      'rid' => $role->rid,
      'permissions' => array(),
    );  
  }
  
  // Fetch set permissions
  $permissions = art_import_permissions();
  
  // Add permissions to roles
  foreach ($permissions as $permission) {
    // Find which roles have the given permission
    foreach ($permission['roles'] as $role) {
      $roles_data[$role]['permissions'][] = $permission['name'];
    }
  }
  
  // Purge permissions, just in case there are any stored
  db_query("DELETE FROM {permission}");
  
  // Store all of the permissions
  foreach ($roles_data as $role_data) {
    $perm = new stdClass;
    $perm->rid = $role_data['rid'];
    $perm->perm = implode($role_data['permissions'], ', ');
    drupal_write_record('permission', $perm);
  }
}
  
/**
 * Configure theme
 */
function art_config_theme() {
  // Disable garland
  db_query("UPDATE {system} SET status = 0 WHERE type = 'theme' and name = '%s'", 'garland');
  
  // Enable Rubik
  db_query("UPDATE {system} SET status = 1 WHERE type = 'theme' and name = '%s'", art_THEME_ADMIN);
  
  // Enable Commons theme
  db_query("UPDATE {system} SET status = 1 WHERE type = 'theme' and name = '%s'", art_THEME);
  
  // Set Rubik theme as the default
  variable_set('admin_theme', art_THEME_ADMIN);
  
  // Set Cube theme as the default
  variable_set('theme_default', art_THEME);

  // Refresh registry
  list_themes(TRUE);
  drupal_rebuild_theme_registry();
}

/**
 * Configure variables
 * 
 * These should be set but not enforced by Strongarm
 */
function art_config_vars() {
  // Set default homepage
  variable_set('site_frontpage', art_FRONTPAGE);
      
  // Keep errors in the log and off the screen
  variable_set('error_level', 0);

  // Do not allow users to create accounts
  variable_set('user_register', 0);

}

/**
 * Various actions needed to clean up after the installation
 */
function art_cleanup() {
  // Rebuild node access database - required after OG installation
  node_access_rebuild();
  
  // Rebuild node types
  node_types_rebuild();
  
  // Rebuild the menu
  menu_rebuild();
  
  // Clear drupal message queue for non-warning/errors
  drupal_get_messages('status', TRUE);

  // Clear out caches
  $core = array('cache', 'cache_block', 'cache_filter', 'cache_page');
  $cache_tables = array_merge(module_invoke_all('flush_caches'), $core);
  foreach ($cache_tables as $table) {
    cache_clear_all('*', $table, TRUE);
  }
  
  // Clear out JS and CSS caches
  drupal_clear_css_cache();
  drupal_clear_js_cache();
  
  // Say hello to the dog!
  watchdog('art', t('Welcome to Art!'));
}

/**
 * Alter the install profile configuration form and provide timezone location options.
 */
function system_form_install_configure_form_alter(&$form, $form_state) {
  // Taken from Open Atrium
  if (function_exists('date_timezone_names') && function_exists('date_timezone_update_site')) {
    $form['server_settings']['date_default_timezone']['#access'] = FALSE;
    $form['server_settings']['#element_validate'] = array('date_timezone_update_site');
    $form['server_settings']['date_default_timezone_name'] = array(
      '#type' => 'select',
      '#title' => t('Default time zone'),
      '#default_value' => 'America/Los_Angeles',
      '#options' => date_timezone_names(FALSE, TRUE),
      '#description' => t('Select the default site time zone. If in doubt, choose the timezone that is closest to your location which has the same rules for daylight saving time.'),
      '#required' => TRUE,
    );
  }
}
