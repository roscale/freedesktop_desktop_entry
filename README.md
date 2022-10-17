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

A Dart package for parsing freedesktop desktop entries on Linux.

## Features

- Obtain values by key
- Obtain localized values by locale
- Localize values according to the locale matching rules of the specification.
- Localize entire desktop entries for easier access.

This package provides the `DesktopEntryKey` enum for convenience, but it doesn't make any assumptions
about value types and whether a key is required or not. All keys are considered optional.

## Usage

```dart
import 'package:freedesktop_desktop_entry/freedesktop_desktop_entry.dart';
import 'dart:io';

final file = File("desktop-entry.desktop");
String content = file.readAsStringSync();

DesktopEntry desktopEntry = DesktopEntry.parse(content);

// Localize an entire desktop entry according to official locale matching rules.
// Probably what you want.
LocalizedDesktopEntry localizedDesktopEntry = desktopEntry.localize(lang: 'fr', country: 'BE');
String? localizedComment = localizedDesktopEntry.entries[DesktopEntryKey.comment.string];
print(localizedComment);

// Get default value of entry.
bool? terminal = desktopEntry.entries[DesktopEntryKey.terminal.string]?.value.getBoolean();
print(terminal);

// Get a single localized value by exact locale.
String? frenchComment =
desktopEntry.entries[DesktopEntryKey.comment.string]
    ?.localizedValues[Locale(lang: 'fr', country: 'BE')];
print(frenchComment);

// Localize a single value according to official locale matching rules.
List<String>? frenchOrDefaultKeywords = desktopEntry.entries[DesktopEntryKey.keywords.string]
    ?.localize(lang: 'fr', country: 'BE')
    .getStringList();
print(frenchOrDefaultKeywords);
```
