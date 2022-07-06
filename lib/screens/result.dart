import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/widgets/responsive.dart';
import 'package:get/get.dart';
import 'package:flutter_boilerplate/utils/localization.dart' show t;

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final count = Get.arguments ?? '0';

    List<Widget> _buildCountNumber() {
      return [
        Text(
          t("COUNT"),
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          count,
          style: Theme.of(context).textTheme.headline4,
        )
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(t("RESULT")),
      ),
      body: Center(
        child: Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildCountNumber(),
          ),
          desktop: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildCountNumber(),
          ),
        ),
      ),
    );
  }
}
