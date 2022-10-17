enum DesktopEntryKey {
  type('Type'),
  version('Version'),
  name('Name'),
  genericName('GenericName'),
  noDisplay('NoDisplay'),
  comment('Comment'),
  icon('Icon'),
  hidden('Hidden'),
  onlyShowIn('OnlyShowIn'),
  notShowIn('NotShowIn'),
  dBusActivatable('DBusActivatable'),
  tryExec('TryExec'),
  exec('Exec'),
  path('Path'),
  terminal('Terminal'),
  actions('Actions'),
  mimeType('MimeType'),
  categories('Categories'),
  implements('Implements'),
  keywords('Keywords'),
  startupNotify('StartupNotify'),
  startupWmClass('StartupWMClass'),
  url('URL'),
  prefersNonDefaultGpu('PrefersNonDefaultGPU'),
  singleMainWindow('SingleMainWindow');

  final String string;

  const DesktopEntryKey(this.string);
}
