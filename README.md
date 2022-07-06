# flutter_boilerplate

[![CI](https://github.com/flutter-seoul/flutter_boilerplate/actions/workflows/ci.yml/badge.svg)](https://github.com/flutter-seoul/flutter_boilerplate/actions/workflows/ci.yml)
[![Github Pages](https://github.com/flutter-seoul/flutter_boilerplate/actions/workflows/pages.yml/badge.svg)](https://github.com/flutter-seoul/flutter_boilerplate/actions/workflows/pages.yml)
[![codecov](https://codecov.io/gh/Jay-flow/flutter_boilerplate/branch/main/graph/badge.svg?token=XDF4A42QLF)](https://codecov.io/gh/Jay-flow/flutter_boilerplate)

Full boilerplate project for Flutter.

![Flutter](./doc/logo.webp)

Do you need another boilerplate?

- [Basic Flutter boilerplate](https://github.com/flutter-seoul/flutter_boilerplate)
- [Firebase boilerplate](https://github.com/flutter-seoul/flutter_boilerplate/tree/firebase)

## Specification

- Localization
- [Get package](https://pub.dev/packages/get) navigation settings
- Asset-related settings (Image, Icon, Color)
- Testing settings
- Supabase settings & boilerplate

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Create an .env file

> You have to create an .env file.
>
> Copy an .env.sample file and create an .env file.

```bash
cp .env.sample .env
```

### 3. Create a Supabase project

Create a Supabase project according to below guide.

- [Project set up](https://supabase.com/docs/guides/with-flutter#project-set-up)
- [Set up the database schema](https://supabase.com/docs/guides/with-flutter#set-up-the-database-schema)

> ⚠️ Caveat
>
> Storage's bucket must be set to public.

### 4. Modify configurations and the `.env` file

According to the guide below.
Check values to enter in `.env`'.

- [Get the API & ANON Keys](https://supabase.com/docs/guides/with-flutter#get-the-api-keys)

- [Setup deep links](https://supabase.com/docs/guides/with-flutter#setup-deep-links)

- Modify the `.env` file in the project root

As a result, an .env file similar to the following must be in the project route.

```bash
ENV="development"
SUPABASE_API_URL="https://kaskjhasdfqwerkjhv.supabase.co"
SUPABASE_ANON_KEY="asasdfjhASDfjkasdjkf8asdfsadf8.asdfkjhasjkdfsdafsdFASDFasdfasdflasdAFSDF9.kjahsdf123124kjhasdf66kjhasdkfjhasASDsdkj"
DEEP_LINK="com.dooboolab.flutter-boilerplate-supabase://login-callback/"
```

> ⚠️ Caveat
>
> Underbar('\_') must not be used for the deep link.

### 5. Run the project

```bash
flutter run
```

---

### 6. (Optional) Using Git hooks

This project consists of github hooks using [lefthooks](https://github.com/evilmartians/lefthook)

- [What is Git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)?

- [How to install and use the Lefthook](https://github.com/evilmartians/lefthook/blob/master/docs/full_guide.md).

### Dependencies

```yaml
# dependencies
cupertino_icons: ^1.0.5
intl: ^0.17.0
get: ^4.6.5
flutter_dotenv: ^5.0.2
logger: ^1.1.0
http: ^0.13.4
supabase: ^0.3.5
supabase_flutter: ^0.3.1+3
image_picker: ^0.8.5+3

# dev_dependencies
flutter_lints: ^2.0.1
test: ^1.20.2
mockito: ^5.2.0
build_runner: ^2.1.11
flutter_native_splash: ^2.2.3+1
change_app_package_name: ^1.1.0
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

Text(Intl.message('appName'));
```

or

```dart
import 'package:flutter_boilerplate/generated/l10n.dart';
...

Text(S.of(context).appName);
```

or

```dart
import 'package:flutter_boilerplate/utils/localization.dart'

t('appName');
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

### How to use environment variables

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

dotenv.get('FOO');

```

## Logging

This project has a [logger](https://pub.dev/packages/flutter_dotenv) installed

### How to use logging

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
