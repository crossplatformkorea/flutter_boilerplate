import 'dart:io';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/providers/user_provider.dart';
import 'package:flutter_seoul/repositories/user_repository.dart';
import 'package:flutter_seoul/utils/assets.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:flutter_seoul/widgets/common/edit_text.dart';
import 'package:flutter_seoul/widgets/model_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class EditProfileArguments {
  final String? title;
  final String? person;

  EditProfileArguments({this.title, this.person});
}

class EditProfile extends HookConsumerWidget {
  const EditProfile({super.key, this.title, this.person});
  final String? title;
  final String? person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(modelProvider);

    final ImagePicker picker = ImagePicker();
    var nameValue = useState('');
    var descValue = useState('');
    var imageFile = useState<XFile?>(null);

    void pickPhoto(ImageSource source) async {
      final pickedFile = await picker.pickImage(source: source);
      imageFile.value = pickedFile;
    }

    return Scaffold(
      backgroundColor: themeNotifier.isDark
          ? const Color(0xFF1E1E1E)
          : const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor:
            themeNotifier.isDark ? Colors.black : const Color(0xFFEDEDED),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: themeNotifier.isDark
              ? Image(
                  width: 230,
                  height: 230,
                  image: Assets.dooboolabLogo,
                )
              : Image(
                  width: 230,
                  height: 230,
                  image: Assets.dooboolab,
                ),
        ),
        leadingWidth: 50,
        actions: [
          IconButton(
              icon: Icon(themeNotifier.isDark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny),
              onPressed: () {
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
              }),
          IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await UserRepository.instance.logout();
              ref.watch(userStateProvider.notifier).removeUser();
            },
            iconSize: 30,
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 36, 16, 36),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: const Offset(4, 4),
                        blurRadius: 16)
                  ],
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          pickPhoto(ImageSource.gallery);
                        },
                        child: Stack(
                          children: [
                            imageFile.value == null
                                ? CircleAvatar(
                                    radius: 85,
                                    backgroundColor: themeNotifier.isDark
                                        ? Colors.white
                                        : Colors.black,
                                    child: const Text(
                                      '사진 선택',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 85,
                                    backgroundImage:
                                        FileImage(File(imageFile.value!.path))),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Display name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        )),
                    EditText(
                      onChanged: (String txt) => nameValue.value = txt,
                      hintText: 'Name',
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        )),
                    EditText(
                      onChanged: (String txt) => descValue.value = txt,
                      hintText: 'Description',
                    ),
                    Button(
                      text: 'Update',
                      onPress: () {},
                      disabled: nameValue.value == '' || descValue.value == '',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
