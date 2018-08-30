# @api private
#
# This class is called from the main tang class for install.
#
class tang::install {
  assert_private('tang::install is a private class')

  package { $::tang::package_name:
    ensure => $::tang::package_ensure,
  }
}
