# flutter_seoul

[![CI](https://github.com/crossplatformkorea/flutter_boilerplate/actions/workflows/ci.yml/badge.svg)](https://github.com/crossplatformkorea/flutter_boilerplate/actions/workflows/ci.yml)
[![Github Pages](https://github.com/crossplatformkorea/flutter_boilerplate/actions/workflows/pages.yml/badge.svg)](https://github.com/crossplatformkorea/flutter_boilerplate/actions/workflows/pages.yml)
[![codecov](https://codecov.io/gh/Jay-flow/flutter_seoul/branch/main/graph/badge.svg?token=XDF4A42QLF)](https://codecov.io/gh/Jay-flow/flutter_seoul)

Full boilerplate project for Flutter.

![Flutter](./doc/logo.jpg)

Do you need another boilerplate?

- [Firebase boilerplate](https://github.com/flutter-seoul/flutter_seoul/tree/firebase)
- [Supabase boilerplate](https://github.com/flutter-seoul/flutter_seoul/tree/supabase)

## Specification

- Localization
- [Provider package](https://pub.dev/packages/provider)
- Asset-related settings (Image, Icon, Color)
- Testing settings

### Dependencies

```yaml
# dependencies
cupertino_icons: ^1.0.5
intl: ^0.17.0
flutter_dotenv: ^5.0.2
logger: ^1.1.0
http: ^0.13.5
freezed_annotation: ^2.2.0
json_annotation: ^4.7.0
image_picker: ^0.8.6
shared_preferences: ^2.0.15
go_router: ^6.0.3
flutter_hooks: ^0.18.5+1
hooks_riverpod: ^2.1.3
sqflite: ^2.2.4+1
path: ^1.8.2
permission_handler: ^10.2.0
flat_list: ^0.1.13

# dev_dependencies
flutter_lints: ^2.0.1
test: ^1.22.0
mockito: ^5.3.2
build_runner: ^2.3.3
flutter_native_splash: ^2.2.16
change_app_package_name: ^1.1.0
freezed: ^2.3.2
json_serializable: ^6.5.4
```

## Getting Started

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Create an .env file

> You have to create an .env file.
>
> Copy an .env.example file and create an .env file.

```bash
cp .env.example .env
```

### 3. Run the project

```bash
flutter run
```

### 4. (Optional) Using Git hooks

This project consists of github hooks using [lefthooks](https://github.com/evilmartians/lefthook)

- [What is Git hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)?

- [How to install and use the Lefthook](https://github.com/evilmartians/lefthook/blob/master/docs/full_guide.md).


> Current flutter version used is [written in CI](https://github.com/flutter-seoul/flutter_seoul/pull/10/files).

## riverpod

Update riverpod provider with below command

```sh
flutter pub run build_runner watch -d
```

## Navigation

[go_router](https://pub.dev/packages/go_router)

### Route settings
```dart
GoRouter routerConfig([String? initialLocation]) => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: initialLocation ?? GoRoutes.authSwitch.fullPath,
      routes: <RouteBase>[
        GoRoute(
          name: GoRoutes.authSwitch.name,
          path: GoRoutes.authSwitch.fullPath,
          builder: (context, state) {
            return const AuthSwitch();
          },
        ),
        GoRoute(
          name: GoRoutes.home.name,
          path: GoRoutes.home.fullPath,
          builder: (context, state) {
            return const Home();
          },
        ),
        GoRoute(
          name: GoRoutes.signIn.name,
          path: GoRoutes.signIn.fullPath,
          builder: (context, state) {
            return const SignIn();
          },
        ),
        GoRoute(
          name: GoRoutes.editProfile.name,
          path: GoRoutes.editProfile.fullPath,
          builder: (context, state) {
            var args = state.extra as EditProfileArguments;

            return EditProfile(
              title: args.title,
              person: args.person,
            );
          },
        ),
        GoRoute(
          name: GoRoutes.sample.name,
          path: GoRoutes.sample.fullPath,
          builder: (context, state) {
            return const Sample();
          },
        ),
        GoRoute(
          name: GoRoutes.result.name,
          path: GoRoutes.result.fullPath,
          builder: (context, state) {
            return const Result();
          },
        ),
      ],
    );
```

### Navigate using go_router
```dart
context.push(GoRoutes.sample.fullPath);
context.go(GoRoutes.sample.fullPath);
context.pop(GoRoutes.sample.fullPath);
```

### Returning values
```dart
onTap: () => context.pop(true)

onTap: () {
  final bool? result = await context.push<bool>('/page2');
  if(result ?? false)...
}
```

## Local Database(sqflite)
### Create DB
```dart
final Future<Database> database = openDatabase(
  join(await getDatabasesPath(), 'item_database.db'),
    onCreate: (db, version) {
        // 데이터베이스에 CREATE TABLE 수행
      return db.execute(
      'CREATE TABLE item(id INTEGER PRIMARY KEY ,title TEXT, content TEXT)',
    );
  },
  version: 1,
);
```

### insert
```dart
db.insert('item', item.toJson(),
  conflictAlgorithm: ConflictAlgorithm.replace);
```

### get
```dart
final List<Map<String, dynamic>> maps = await db.query('item');
  return List.generate(maps.length, (i) {
    return ItemModel(
      id: maps[i]['id'],
      title: maps[i]['title'],
      content: maps[i]['content'],
    );
  });
```

### delete
```dart
db.delete(
  'item',
  where: 'id = ?',
  whereArgs: [id],
);
```

### update
```dart
db.update(
  'item',
  item.toJson(),
  where: 'id = ?',
  whereArgs: [item.id],
);
```

## Permission

### IOS
```dart
flutter pub add permission_handler
```
Add permission to your Info.plist file.

[IOS permissions list]

[IOS permissions list]:https://github.com/Baseflow/flutter-permission-handler/blob/master/permission_handler/example/ios/Runner/Info.plist

### Android
Add permissions to your AndroidManifest.xml file.

[Android permissions list]

[Android permissions list]:https://github.com/Baseflow/flutter-permission-handler/blob/master/permission_handler/example/android/app/src/main/AndroidManifest.xml

### Permission Example
```dart
var status = await Permission.camera.status;
if (status.granted) {
  /// you can do something if granted
}

if (status.isDenied) {
  /// you can do something if isDenied
}

if (status == PermissionStatus.permanentlyDenied) {
  /// If permanently denied, have to openAppSettings()
  await openAppSettings();
}

if (await Permission.location.isRestricted) {

}
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
import 'package:flutter_seoul/generated/l10n.dart';
...

Text(S.of(context).appName);
```

or

```dart
import 'package:flutter_seoul/utils/localization.dart'

localization(context).appName;
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

### Organizing assets

To use the image or icon, you can use it as below.

```dart
import 'package:flutter_seoul/utils/asset.dart' as asset;
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

### Using environment variables

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

dotenv.get('FOO');

```

## Logging

This project has a [logger](https://pub.dev/packages/flutter_dotenv) installed

### Using the logging

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

## Freezed

Lastly, [freezed](https://pub.dev/packages/freezed) package is used in the boilerplate.

After creating the model, you need to run the below command to generate and sync the data structure.

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

> If using vscode, you can [download extension](https://marketplace.visualstudio.com/items?itemName=Kaiqun.build-runner) for auto build.


### Simple usage

In current boilerplate, `user.dart` file is created and below code is written.

```dart
import "package:freezed_annotation/freezed_annotation.dart";

part "user.freezed.dart";
part "user.g.dart";

@freezed
class User with _$User {
  const factory User({
    required String displayName,
    required int age,
    required String organization,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

Running `flutter pub run build_runner build --delete-conflicting-outputs`, will generate [b60b3d5](https://github.com/flutter-seoul/flutter_seoul/commit/b60b3d55a21df4328e0991df2bd489d9cf529143).
