import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/controllers/count_controller.dart';
import 'package:flutter_boilerplate/screens/result.dart';
import 'package:flutter_boilerplate/screens/sample.dart';
import 'package:flutter_boilerplate/utils/constants.dart';
import 'package:flutter_boilerplate/utils/localization.dart' show t;
import 'package:get/get.dart';

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
        title: Text(t("APP_NAME")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(t("COUNT")),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Obx(
                () => Text(
                  "${controller.count.value}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            TextButton(
              child: Text(t("GO_TO_RESULT")),
              onPressed: () {
                Get.to(
                  () => const Result(),
                  arguments: "${controller.count.value}",
                );
              },
            ),
            const Image(
              width: 300,
              height: 300,
              image: AssetImage(
                imageLogo,
              ),
            ),
            TextButton(
              child: Text(t("GO_TO_SAMPLE")),
              onPressed: () {
                Get.to(
                  () => const Sample(),
                  arguments: "${controller.count.value}",
                );
              },
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
