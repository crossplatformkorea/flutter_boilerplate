import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/utils/localization.dart';
import 'package:flutter_boilerplate/widgets/auth_required_state.dart';
import 'package:flutter_boilerplate/widgets/avatar.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends AuthRequiredState<Account> {
  final _usernameController = TextEditingController();
  final _websiteController = TextEditingController();
  String? _userId;
  String? _avatarUrl;
  var _loading = false;

  Future<void> _getProfile(String userId) async {
    setState(() {
      _loading = true;
    });

    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single()
        .execute();
    final error = response.error;

    if (error != null && response.status != 406) {
      Get.snackbar(
        t('error'),
        error.message,
      );
    }

    final data = response.data;

    if (data != null) {
      _usernameController.text = (data['username'] ?? '') as String;
      _websiteController.text = (data['website'] ?? '') as String;
      _avatarUrl = (data['avatar_url'] ?? '') as String;
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    final userName = _usernameController.text;
    final website = _websiteController.text;
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'username': userName,
      'website': website,
      'updated_at': DateTime.now().toIso8601String(),
    };

    final response = await supabase.from('profiles').upsert(updates).execute();
    final error = response.error;

    if (error != null) {
      Get.snackbar(t('error'), error.message);
    } else {
      Get.snackbar(
        t('success'),
        t('profileUpdateSuccessful'),
      );
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> _signOut() async {
    final response = await supabase.auth.signOut();
    final error = response.error;

    if (error != null) {
      Get.snackbar(t('error'), error.message);
    }
  }

  Future<void> _onUpload(String imageUrl) async {
    final response = await supabase.from('profiles').upsert({
      'id': _userId,
      'avatar_url': imageUrl,
    }).execute();
    final error = response.error;

    if (error != null) {
      Get.snackbar(t('error'), error.message);
    }

    setState(() {
      _avatarUrl = imageUrl;
    });

    Get.snackbar(
      t('success'),
      t('updatedProfileImage'),
    );
  }

  @override
  void onAuthenticated(Session session) {
    final user = session.user;

    if (user != null) {
      _userId = user.id;
      _getProfile(user.id);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t('profile'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Avatar(
            imageUrl: _avatarUrl,
            onUpload: _onUpload,
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: t('userName'),
            ),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _websiteController,
            decoration: InputDecoration(
              labelText: t('website'),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _updateProfile,
            child: Text(
              _loading ? t('saving') : t('update'),
            ),
          ),
          const SizedBox(height: 18),
          TextButton(
            onPressed: _signOut,
            child: Text(
              t('signOut'),
            ),
          ),
        ],
      ),
    );
  }
}
