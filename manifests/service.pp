# @api private
#
# This class is meant to be called from tang to manage the tang service.
#
class tang::service {
  assert_private('tang::service is a private class')

  service { $::tang::service_name:
    ensure     => $::tang::service_ensure,
    enable     => $::tang::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
