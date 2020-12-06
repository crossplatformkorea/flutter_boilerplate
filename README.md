# flutter_boilerplate

Full boilerplate project for flutter.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev).

## Boilerplate
> Specification
* localization
* folder structures
  - models, screens, shared, utils 

# Structures
```text
project/
├─ android
├─ ios
├─ lib
│  └─ models // models used in project
│  └─ screens // list of screens
│  └─ shared // widgets that is used in screens multiply
│  └─ utils // useful materials - localization, theme, general
│  └─ main.dart // root of dart file
├─ res/
│  └─ icons
│  └─ langs
├─ test/
├─ .metadata
├─ .gitignore
├─ .packages
├─ .flutter_boilerplate.iml
├─ .flutter_boilerplate_android.iml
├─ .pubspec.lock
├─ .pubspec.yaml
└─ README.md
```

## Running the project
```sh
pub get
flutter run ios
flutter run android
```

## Localization
We've defined Localization strings in json which is placed in `res/langs` dir.
We used [flutter_localizations](https://flutter.io/tutorials/internationalization/#setting-up) pacakage for localization.
```
import '../utils/localization.dart' show Localization;

var localization = Localization.of(context); /// We need context to be passed.

/// In widget
Text(localization.trans('LOADING'));
```
