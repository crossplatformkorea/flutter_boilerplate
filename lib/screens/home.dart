import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/apis/sample.dart';
import 'package:flutter_boilerplate/controller/count_controller.dart';
import 'package:flutter_boilerplate/screens/result.dart';
import 'package:flutter_boilerplate/utils/asset.dart' as asset;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(CountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Intl.message("appName")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You have pushed the button this many times:",
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Obx(
                () => Text(
                  "${controller.count.value}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            TextButton(
              child: const Text("Go to the result page."),
              onPressed: () {
                Get.to(
                  () => const Result(),
                  arguments: "${controller.count.value}",
                );
              },
            ),
            Image(
              image: asset.Images.logo,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increase(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
