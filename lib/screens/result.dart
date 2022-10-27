import 'package:flutter/material.dart';
import 'package:flutter_seoul/widgets/back_app_bar.dart';
import 'package:flutter_seoul/widgets/responsive.dart';
import 'package:flutter_seoul/utils/localization.dart' show t;

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    const count = '0';

    List<Widget> buildCountNumWidgets() {
      return [
        Text(
          t("COUNT"),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          count,
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ];
    }

    return Scaffold(
      appBar: BackAppBar(
        title: Text(t("RESULT")),
      ),
      body: Center(
        child: Responsive(
          mobile: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildCountNumWidgets(),
          ),
          desktop: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildCountNumWidgets(),
          ),
        ),
      ),
    );
  }
}
