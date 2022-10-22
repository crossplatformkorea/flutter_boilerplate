import 'dart:io';
import 'package:flutter_boilerplate/controllers/count_controller.dart';
import 'package:flutter_boilerplate/widgets/edit_text.dart';
import 'package:flutter_boilerplate/widgets/seoul_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.put(CountController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late String _nameValue = "";
  late String _descValue = "";
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final RxBool _isLightTheme = false.obs;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  void pickPhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  _getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') != null ? prefs.getBool('theme') : false;
    }).obs;

    bool copyValue = (await isLight.value)!;
    setState(() {
      _isLightTheme.value = copyValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _getThemeStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLightTheme.value
          ? const Color(0xFF1E1E1E)
          : const Color(0xFFEDEDED),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: _isLightTheme.value
              ? Image.asset(
                  'res/images/dooboolabBlack.png',
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  'res/images/dooboolab.png',
                  fit: BoxFit.contain,
                ),
        ),
        leadingWidth: 50,
        actions: [
          ObxValue(
            (data) => Switch(
              inactiveTrackColor: Colors.black,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.white,
              activeColor: Colors.white,
              value: _isLightTheme.value,
              onChanged: (val) {
                setState(() {
                  _isLightTheme.value = val;
                });
                Get.changeThemeMode(
                  _isLightTheme.value ? ThemeMode.dark : ThemeMode.light,
                );
                _saveThemeStatus();
              },
            ),
            false.obs,
          ),
          IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => Get.back(),
            iconSize: 30,
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                              "Profile",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          )),
                      Center(
                        child: InkWell(
                          onTap: () {
                            pickPhoto(ImageSource.gallery);
                          },
                          child: Stack(
                            children: [
                              _imageFile == null
                                  ? CircleAvatar(
                                      radius: 85,
                                      backgroundColor: _isLightTheme.value
                                          ? Colors.white
                                          : Colors.black,
                                      child: const Text(
                                        "사진 선택",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 85,
                                      backgroundImage:
                                          FileImage(File(_imageFile!.path))),
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
                              "Display name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )),
                      EditText(
                        onChanged: (String txt) => setState(() {
                          _nameValue = txt;
                        }),
                        hintText: 'Name',
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 24, 0, 10),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )),
                      EditText(
                        onChanged: (String txt) => setState(() {
                          _descValue = txt;
                        }),
                        hintText: 'Description',
                      ),
                      SeoulButton(
                        onPressed: () {
                          // todo update profile
                        },
                        disabled: _nameValue == "" || _descValue == "",
                        style: SeoulButtonStyle(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .background,
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 40, 0, 24),
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16)),
                        child: Text(
                          "Update",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
