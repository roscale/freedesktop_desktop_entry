## 0.6.1

- Faster indexing by using a properly implemented immutable hashmap.

## 0.6.0

- Faster indexing that offloads the work to an isolate.
- All installed themes are indexed.

## 0.5.0

- `LocalizedDesktopEntry` must point to its original `DesktopEntry`.
- Rename `getAppBaseDirectories` to `getApplicationDirectories`.
- Add `parseAllInstalledDesktopFiles` function.

## 0.4.0

- Rename `IconTheme` to `FreedesktopIconTheme` because it interferes with Flutter.

## 0.3.4

- Add support for absolute path in `findIcon`.

## 0.3.3

- Added `getAppBaseDirectories` function.

## 0.3.2

- Fix icon cache not working.

## 0.3.1

- Cache icon mappings.

## 0.3.0

- Add support for icon lookup.

## 0.2.2

- Fix entry parsing when the value contains '='.

## 0.2.1

- Improve the `README` and add examples.

## 0.2.0

- Add support for actions.

## 0.1.0

- Initial version.
