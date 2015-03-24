# == Class checkmk::agent
#
# Install and configure Check_mk agent
#
class checkmk::agent (
  $deb_path = undef
) {

  package {'cron-apt':
    ensure => installed,
  }
  if $deb_path == undef {
      package {'check-mk-agent':
        ensure => installed,
      }
  } else {
      package {'check-mk-agent':
        provider => "dpkg",
        ensure => latest,
        source => $deb_path,
      }
  }
  checkmk::plugin{
    ['puppet','conntrack','apt',
      'smart','dmraid','mk_mysql',
      'mk_postgres','lnx_psperf', 'lmsensors',
      'bird', 'mk_logwatch', 'netstat.linux']:
  }
}
