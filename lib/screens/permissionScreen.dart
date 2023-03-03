import 'dart:io';

import 'package:flat_list/flat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/widgets/common/alert_dialog.dart';
import 'package:flutter_seoul/widgets/common/styles.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionType {
  PermissionType(
      {required this.permission, required this.onPress, this.trailing});

  final String permission;
  final Function() onPress;
  final String? trailing;
}

class PermissionScreen extends HookWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> requestPermission(
        Future<PermissionStatus> Function() permission) async {
      var status = await permission();
      if (status == PermissionStatus.granted) {
        if (context.mounted) {
          alertDialog.confirm(context, title: '권한 승인', content: '이미 승인되었습니다.');
        }
        return Future.value(true);
      } else if (status == PermissionStatus.denied) {
        if (context.mounted) {
          alertDialog.confirm(context, title: '권한 거부', content: '권한이 거부되었습니다.');
        }
      } else if (status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }

      if (context.mounted) {
        alertDialog.confirm(context, title: '권한 거부', content: '권한이 거부되었습니다.');
      }
      return Future.value(false);
    }

    var permissionData = useState<List<PermissionType>>([
      PermissionType(
        permission: 'Storage',
        onPress: () {
          if (Platform.isAndroid) {
            requestPermission(Permission.storage.request);
          }
        },
        trailing: 'Android Only',
      ),
      PermissionType(
        permission: 'Camera',
        onPress: () => requestPermission(Permission.camera.request),
      ),
      PermissionType(
        permission: 'Location',
        onPress: () => requestPermission(Permission.location.request),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission'),
      ),
      body: FlatList<PermissionType>(
          data: permissionData.value,
          listHeaderWidget: const ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 1),
            ),
            title: Text(
              'Permission',
              style: TitleTextStyle(),
            ),
            trailing: Text(
              'Type',
              style: TitleTextStyle(),
            ),
          ),
          buildItem: (item, index) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1),
              ),
              title: Text(item.permission),
              trailing: Text(item.trailing ?? ''),
              onTap: item.onPress,
            );
          }),
    );
  }
}
