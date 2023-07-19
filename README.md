<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Dart package for parsing freedesktop (XDG) desktop entries on Linux.

## Features

- Obtain values by key, including action groups.
- Obtain localized values.
- Icon lookup.

This package provides the `DesktopEntryKey` enum for convenience, but it doesn't make any assumptions
about value types and whether a key is required or not. All keys are considered optional.

## Usage

### Parse a desktop entry file

```dart
import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'dart:io';

final file = File("desktop-entry.desktop");
DesktopEntry desktopEntry = await DesktopEntry.parseFile(file);
```

### Localize an entire desktop entry

```dart
LocalizedDesktopEntry localizedDesktopEntry = desktopEntry.localize(lang: 'fr', country: 'BE');
```

### Get a localized value

```dart
String? localizedComment = localizedDesktopEntry.entries[DesktopEntryKey.comment.string];
// OR
String? localizedComment = desktopEntry.entries[DesktopEntryKey.comment.string]?.localize(lang: 'fr', country: 'BE');
```
Unless you are only interested in a few fields, prefer localizing the entire desktop entry to avoid having to specify
the locale every time.

The `localize` methods will localize the values according to official locale matching rules, and
uses the default value if no locale is matched. This is most probably what you want to do.

### Get the default value

```dart
String? name = desktopEntry.entries[DesktopEntryKey.name.string]?.value;
bool? terminal = desktopEntry.entries[DesktopEntryKey.terminal.string]?.value.getBoolean();
List<String>? keywords = desktopEntry.entries[DesktopEntryKey.keywords.string]?.value.getStringList();
bool? startupNotify = desktopEntry.entries['X-KDE-StartupNotify']?.value.getBoolean();
```

### Get a value by exact locale

```dart
String? frenchComment = desktopEntry.entries[DesktopEntryKey.comment.string]?.localizedValues[Locale(lang: 'fr', country: 'BE')];
```

### Find an icon

```dart
final themes = FreedesktopIconThemes();
File? file = await themes.findIcon(
    IconQuery(
        name: 'firefox',
        size: 32,
        scale: 2,
        extensions: ['png'],
    ),
);
```

The first time you do an icon lookup, all installed themes on your system will be indexed.
If you want to preload the themes, call `FreedesktopIconThemes.loadThemes`.

If new icons are installed, the next time you call `FreedesktopIconThemes.findIcon` it will index all themes once again
before returning you an icon.

You can specify `preferredThemes` in `IconQuery`. This prioritizes the search to the list of theme names you've given before searching elsewhere.
These theme names must be directory names, not user-visible names. For example `breeze-dark` and not `Breeze Dark`.
