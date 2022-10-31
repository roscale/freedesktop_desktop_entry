enum IconThemeKey {
  name('Name'),
  comment('Comment'),
  inherits('Inherits'),
  directories('Directories'),
  scaledDirectories('ScaledDirectories'),
  hidden('Hidden'),
  example('Example'),
  size('Size'),
  scale('Scale'),
  context('Context'),
  type('Type'),
  maxSize('MaxSize'),
  minSize('MinSize'),
  threshold('Threshold'),
  displayName('DisplayName'),
  embeddedTextRectangle('EmbeddedTextRectangle'),
  attachPoints('AttachPoints');

  final String string;

  const IconThemeKey(this.string);
}
