# Class: tang
# ===========================
#
# Main class that includes all other classes for the tang module.
#
# @param package_ensure Whether to install the tang package, and/or what version. Values: 'present', 'latest', or a specific version number. Default value: present.
# @param package_name Specifies the name of the package to install. Default value: 'tang'.
# @param service_enable Whether to enable the tang service at boot. Default value: true.
# @param service_ensure Whether the tang service should be running. Default value: 'running'.
# @param service_name Specifies the name of the service to manage. Default value: 'tang'.
#
class tang (
  String                     $package_ensure = 'present',
  String                     $package_name   = 'tang',
  Boolean                    $service_enable = true,
  Enum['running', 'stopped'] $service_ensure = 'running',
  String                     $service_name   = 'tang',
  ) {
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      contain tang::install
      contain tang::config
      contain tang::service

      Class['tang::install']
      -> Class['tang::config']
      ~> Class['tang::service']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
