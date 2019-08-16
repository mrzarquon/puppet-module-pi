plan pi::bootstrap (
  TargetSpec $nodes,
  Boolean $remove_gem = false,
  $puppet_version = '6.6.0',
  $puppet_deb_url = 'https://dl.bintray.com/sharpie/puppet-raspbian-spike/puppet-raspbian-spike-release_1.0.0-1stretch_all.deb',
  $bootstrap_class = 'pi::helloworld',
) {

  #add_to_group($nodes, 'raspberrybootstrap')

  if $remove_gem {
    $rm_results = run_task('pi::rm_gem_puppet', $nodes)
    $rm_results.each |$result| {
      out::message("Node: ${result.target.name} gem removal logs: ${result.message}")
    }
  }

  $puppet_results = run_task('pi::puppet', $nodes, puppet_version => $puppet_version, puppet_deb_url => $puppet_deb_url)

  $puppet_results.each |$result| {
    out::message("Node: ${result.target.name} puppet install logs: ${result.message}")
  }

  apply_prep($nodes)

  $reports = apply ($nodes) {
    include $bootstrap_class
  }

  $reports.each |$report| {
    out::message("Node: ${report.target.name} Puppet Apply Logs: ${report.report['logs']}")
  }

}
