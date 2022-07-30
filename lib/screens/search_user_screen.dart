import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/controllers/user_controller.dart';
import 'package:flutter_boilerplate/models/user_model.dart';
import 'package:flutter_boilerplate/widgets/circle_loading_indicator.dart';
import 'package:flutter_boilerplate/widgets/search_text_field.dart';
import 'package:get/get.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final UserController _userController = Get.put(UserController());

  List<UserModel> _users = [];
  bool _isLoading = false;

  Future<void> _onSearchTextChanged(String searchText) async {
    _changeLoadingState(true);
    _users = await _userController.searchUsersByName(searchText);
    _changeLoadingState(false);
  }

  void _changeLoadingState(bool isLoading) {
    if (mounted) {
      setState(() => _isLoading = isLoading);
    }
  }

  Future<void> _addFavoriteUser(String id) async {
    await _userController.storeFavoriteUser(id);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search user"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchTextField(
                        cursorColor: Colors.black,
                        autofocus: true,
                        onSearched: _onSearchTextChanged,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const CircleLoadingIndicator()
                    : ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          UserModel user = _users[index];

                          return ListTile(
                            title: Text(user.name),
                            onTap: () => _addFavoriteUser(user.id),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
