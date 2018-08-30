node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'tang':
    require => Notify['enduser-before'],
    before  => Notify['enduser-after'],
  }

}
