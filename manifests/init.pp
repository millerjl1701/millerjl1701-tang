# Class: tang
# ===========================
#
# Main class that includes all other classes for the tang module.
#
# @param package_ensure Whether to install the tang package, and/or what version. Values: 'present', 'latest', or a specific version number.
# @param package_name Specifies the name of the package to install.
# @param service_enable Whether to enable the tang service at boot.
# @param service_ensure Whether the tang service should be running.
# @param service_name Specifies the name of the service to manage.
#
class tang (
  String                     $package_ensure = 'present',
  String                     $package_name   = 'tang',
  Boolean                    $service_enable = true,
  Enum['running', 'stopped'] $service_ensure = 'running',
  String                     $service_name   = 'tangd.socket',
) {
  case $facts['os']['name'] {
    'RedHat', 'CentOS', 'AlmaLinux': {
      contain tang::install
      contain tang::config
      contain tang::service

      Class['tang::install']
      -> Class['tang::config']
      ~> Class['tang::service']
    }
    default: {
      fail("${facts['os']['name']} not supported")
    }
  }
}
