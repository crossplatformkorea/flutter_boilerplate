# flutter_boilerplate

Full boilerplate project for Flutter.

![Flutter](https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png)

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Create an .env file

> You have to create an .env file.
>
> Copy an .env_example file and create an .env file.

```bash
cp .env_example .env
```

### 3. Run the project

```bash
flutter run
```

## Specification

- Localization
- [Get package](https://pub.dev/packages/get) navigation settings
- Asset-related settings (Image, Icon, Color)
- Testing settings

### Dependencies

```yaml
# dependencies
cupertino_icons: ^1.0.2
intl: ^0.17.0
get: ^4.6.1
flutter_dotenv: ^5.0.2
logger: ^1.1.0
http: ^0.13.4

# dev_dependencies
flutter_lints: ^1.0.0
test: ^1.17.12
mockito: ^5.0.17
build_runner: ^2.1.7
integration_test: ^0.8.1
flutter_native_splash: ^1.3.3
```

## Folder Structures

```text
├── android
├── build
├── ios
├── lib
│   ├── apis
│   ├── controller
│   ├── generated
│   │   ├── intl
│   │   │   ├── messages_all.dart
│   │   │   ├── messages_en.dart
│   │   │   └── messages_ko.dart
│   │   └── l10n.dart
│   ├── l10n
│   │   ├── intl_en.arb
│   │   └── intl_ko.arb
│   ├── main.dart
│   ├── models
│   │   └── sample.dart
│   ├── screens // <- or pages
│   │   └── home.dart
│   ├── utils
│   │   ├── asset.dart
│   │   └── logger.dart
│   └── widgets // <- or components
│       └── sample.dart
├── res
│   ├── icons
│   │   └── logo.png
│   ├── images
│   │   └── logo.png
│   ├── fonts // <- If you want, you have to make it here yourself.
├── test
│   └── widget_test.dart
├── analysis_options.yaml
├── flutter_boilerplate.iml
├── pubspec.lock
├── pubspec.yaml
├──.env_example
└── README.md
```

## Localization

The repository is localizing using the arb recommended on [the official Flutter website](https://docs.flutter.dev/development/accessibility-and-localization/internationalization).

To use it, you need to install the Flutter Intl extension in your VSCode or Android studio.

You can go to the link below for installation.

- [Visual studio code](https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl)
- [Android studio](https://plugins.jetbrains.com/plugin/13666-flutter-intl)

When Flutter Intl is installed, a dart file is automatically created when modifying the arb file.

For posture information on this, check the document on the download link.
For Korean users, you can check it on [this link](https://medium.com/flutter-seoul/flutter-localizations-%EC%99%84%EC%A0%84-%EC%A0%95%EB%B3%B5-%ED%95%98%EA%B8%B0-8fa5f50a3fd2).

### How to use localization

```dart
import 'package:intl/intl.dart';
...

Text(Intl.message('appName'))
```

or

```dart
import 'package:flutter_boilerplate/generated/l10n.dart';
...

Text(S.of(context))
```

## Assets

> The following related things are called Assets.
>
> - Images
> - Icons
> - Fonts
>
> Things related to assets are created under the `res` folder.

```text
└── res
    ├── icons
    │   └── logo.png
    ├── images
    │   └── logo.png
    └── fonts // <- If you want, you have to make it here yourself.
```

### How to use asset

To use the image or icon, you can use it as below.

```dart
import 'package:flutter_boilerplate/utils/asset.dart' as asset;
...

Image(
  image: asset.Images.logo,
)
```

## Environment variables

This project has a flutter_dotenv installed.
Enter the environmental variable you want in the `.env` file as follows.

```text
FOO=foo
BAR=bar
FOOBAR=$FOO$BAR
ESCAPED_DOLLAR_SIGN='$1000'
# This is a comment
```

### How to use

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

dotenv.get('FOO');

```

## Logging

This project has a [logger](https://pub.dev/packages/flutter_dotenv) installed

### How to use

```dart
logger.d('Log message with 2 methods');
logger.i('Info message');
logger.w('Just a warning!');
logger.e('Error! Something bad happened');
```

![logger](https://raw.githubusercontent.com/leisim/logger/master/art/screenshot.png)

## Native splash screen

This project has a flutter_native_splash package installed.
This makes it possible to show the native splash screen.
Please refer to [this link](https://pub.dev/packages/flutter_native_splash#usage) for instructions on how to use it.

![native_splash_image](https://raw.githubusercontent.com/jonbhanson/flutter_native_splash/master/splash_demo.gif)
