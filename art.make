; Make file for Art Websites.
api = 2
core = 6.x

projects[drupal][version] = "6.19"

; Modules

projects[ctools][subdir] = "contrib"
projects[ctools][version] = "1.7"

projects[context][subdir] = "contrib"
projects[context][version] = "3.0"

projects[views][subdir] = "contrib"
projects[views][version] = "2.11"

projects[install_profile_api][subdir] = "contrib"
projects[install_profile_api][version] = "2.1"

projects[node_export][subdir] = "contrib"
projects[node_export][version] = "2.21"

projects[cck][subdir] = "contrib"
projects[cck][version] = "2.8"

projects[filefield][subdir] = "contrib"
projects[filefield][version] = "3.7"

projects[imagefield][subdir] = "contrib"
projects[imagefield][version] = "3.7"

projects[link][subdir] = "contrib"
projects[link][version] = "2.9"

projects[date][subdir] = "contrib"
projects[date][version] = "2.6"

projects[imageapi][subdir] = "contrib"
projects[imageapi][version] = "1.9"

projects[imagecache][subdir] = "contrib"
projects[imagecache][version] = "2.0-beta10"

projects[imagecache_actions][subdir] = "contrib"
projects[imagecache_actions][version] = "1.7"

projects[token][subdir] = "contrib"
projects[token][version] = "1.15"

projects[rules][subdir] = "contrib"
projects[rules][version] = "1.3"

projects[wysiwyg][subdir] = "contrib"
projects[wysiwyg][version] = "2.1"

projects[better_formats][subdir] = "contrib"
projects[better_formats][version] = "1.2"

projects[admin_menu][subdir] = "contrib"
projects[admin_menu][version] = "1.6"

projects[diff][subdir] = "contrib"
projects[diff][version] = "2.1"

projects[pathauto][subdir] = "contrib"
projects[pathauto][version] = "1.5"

projects[jquery_ui][subdir] = "contrib"
projects[jquery_ui][version] = "1.4"

projects[vertical_tabs][subdir] = "contrib"
projects[vertical_tabs][version] = "1.0-rc1"

projects[auto_nodetitle][subdir] = "contrib"
projects[auto_nodetitle][version] = "1.2"

projects[backup_migrate][subdir] = "contrib"
projects[backup_migrate][version] = "2.3"

projects[formfilter][subdir] = "contrib"
projects[formfilter][version] = "1.0"

projects[imce][subdir] = "contrib"
projects[imce][version] = "2.0-rc2"

projects[imce_wysiwyg][subdir] = "contrib"
projects[imce_wysiwyg][version] = "1.1"

projects[jquery_update][subdir] = "contrib"
projects[jquery_update][version] = "1.1"

projects[login_destination][subdir] = "contrib"
projects[login_destination][version] = "2.10"

projects[menutrails][subdir] = "contrib"
projects[menutrails][version] = "1.1"

projects[page_title][subdir] = "contrib"
projects[page_title][version] = "2.3"

projects[path_redirect][subdir] = "contrib"
projects[path_redirect][version] = "1.0-rc1"

projects[semanticviews][subdir] = "contrib"
projects[semanticviews][version] = "1.1"

projects[views_bulk_operations][subdir] = "contrib"
projects[views_bulk_operations][version] = "1.10"

projects[strongarm][subdir] = "contrib"
projects[strongarm][version] = "2.0"

projects[features][subdir] = "contrib"
projects[features][version] = "1.0"

; Themes
projects[rubik][version] = "3.0-beta2"
projects[tao][version] = "3.2"
projects[zen][version] = "2.0"

;jQuery UI
libraries[jquery_ui][download][type] = "get"
libraries[jquery_ui][download][url] = "http://jquery-ui.googlecode.com/files/jquery-ui-1.7.zip"
libraries[jquery_ui][directory_name] = "jquery.ui"
libraries[jquery_ui][destination] = "modules/contrib/jquery_ui"

; CKEditor
libraries[ckeditor][download][type]= "get"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.4/ckeditor_3.4.zip"
libraries[ckeditor][directory_name] = "ckeditor"
libraries[ckeditor][destination] = "libraries"

; Profile
projects[art][type] = "profile"
projects[art][download][type] = "git"
projects[art][download][destination] = "profiles"
projects[art][download][url]= "git://github.com/rocksoup/art_profile.git"
