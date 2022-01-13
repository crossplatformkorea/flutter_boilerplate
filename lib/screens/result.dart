import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    final count = Get.arguments ?? '0';

    List<Widget> _buildCountNumber() {
      return [
        Text(
          'Count',
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
        title: const Text("Result"),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildCountNumber(),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildCountNumber(),
              );
            }
          },
        ),
      ),
    );
  }
}
