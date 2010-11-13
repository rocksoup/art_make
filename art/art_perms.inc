<?php

/*
 * Map of permissions and associated roles
 * 
 * @return
 *   An associative array containing permissions and the roles
 *   to which the permission is granted to
 */
function art_import_permissions() {
  $permissions = array();

  // Permission: access comments
  $permissions[] = array(
    'name' => 'access comments',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
    ),
  );

  // Permission: access content
  $permissions[] = array(
    'name' => 'access content',
    'roles' => array(
      '0' => 'anonymous user',
    ),
  );

  // Permission: access user profiles
  $permissions[] = array(
    'name' => 'access user profiles',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
    ),
  );


  // Permission: create page content
  $permissions[] = array(
    'name' => 'create page content',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
    ),
  );

  // Permission: delete any page content
  $permissions[] = array(
    'name' => 'delete any page content',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
    ),
  );


  // Permission: delete own page content
  $permissions[] = array(
    'name' => 'delete own page content',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
    ),
  );

  // Permission: edit any page content
  $permissions[] = array(
    'name' => 'edit any page content',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
      '1' => art_CONTENT_ROLE,
    ),
  );

  // Permission: edit own page content
  $permissions[] = array(
    'name' => 'edit own page content',
    'roles' => array(
      '0' => art_MANAGER_ROLE,
    ),
  );

  return $permissions;
}
