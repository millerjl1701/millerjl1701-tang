# tang

master branch: [![Build Status](https://secure.travis-ci.org/millerjl1701/millerjl1701-tang.png?branch=master)](http://travis-ci.org/millerjl1701/millerjl1701-tang)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with tang](#setup)
    * [What tang affects](#what-tang-affects)
    * [Beginning with tang](#beginning-with-tang)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Module Description

This module manages the installation and configuration of the TANG server service - the server side component of Network Bound Disk Encryption (NBDE).

Documentation concerning the TANG service on RHEL/CentOS systems may be found at:
* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-using_network-bound_disk_encryption
* https://rhelblog.redhat.com/2018/04/13/an-easier-way-to-manage-disk-decryption-at-boot-with-red-hat-enterprise-linux-7-5-using-nbde/

Note: NBDE was initilly released with RedHat/CentOS version 7.4 with complete support arriving with RedHat/CentOS 7.5.

## Setup

### What tang affects

* Packages: tang (yum will also install jose and libjose as dependencies)
* Service: tangd.socket

### Beginning with tang

In order to install and configure the TANG server, all that is needed in a puppet code manifest is `include ::tang`.

## Usage

### Install a particular version of the TANG server service

```puppet
  class { 'tang':
    package_ensure => '6-1.el7',
  }
```

## Reference

Generated puppet strings documentation with examples is available from [https://millerjl1701.github.io/millerjl1701-tang](https://millerjl1701.github.io/millerjl1701-tang).

The puppet strings documentation is also included in the /docs folder.

## Limitations

For RedHat/CentOS systems, the TANG server service will only run on version 7.4 or higher. Attempting to use this class with lower versions will likely be problematic.

The RedHat recommended HA configuration for the TANG server service is to deploy two or more TANG servers and register clients to both (all) servers. The alternative approach to HA is to share the TANG server keys between all the servers. While Puppet could allow for this, it will not be implemented at this time due to risk of key compromise.

## Development

Please see the [CONTRIBUTING document](CONTRIBUTING.md) for information on how to get started developing code and submit a pull request for this module. While written in an opinionated fashion at the start, over time this can become less and less the case.

### Contributors

To see who is involved with this module, see the [GitHub list of contributors](https://github.com/millerjl1701/millerjl1701-tang/graphs/contributors) or the [CONTRIBUTORS document](CONTRIBUTORS).
