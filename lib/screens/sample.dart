import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/tools.dart';
import 'package:flutter_boilerplate/widgets/back_app_bar.dart';
import 'package:flutter_boilerplate/widgets/custom_checkbox.dart';
import 'package:flutter_boilerplate/widgets/outline_button.dart';
import 'package:flutter_boilerplate/widgets/seoul_button.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  List<bool> _agreementValues = List.generate(3, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SeoulButton(
                onPressed: () {
                  setState(() {
                    _agreementValues =
                        _agreementValues.map((e) => true).toList();
                    logger.d(_agreementValues);
                  });
                },
                style: const SeoulButtonStyle(
                  width: double.infinity,
                  height: 50,
                ),
                child: const Text("전체동의"),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: CustomCheckbox(
                      value: _agreementValues[0],
                      onChanged: (value) {
                        _agreementValues[0] = value;
                      },
                    ),
                  ),
                  const Text('agreement 1'),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: CustomCheckbox(
                      value: _agreementValues[1],
                      onChanged: (value) {
                        _agreementValues[1] = value;
                      },
                    ),
                  ),
                  const Text('agreement 2'),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: CustomCheckbox(
                      value: _agreementValues[2],
                      onChanged: (value) {
                        _agreementValues[2] = value;
                      },
                    ),
                  ),
                  const Text('agreement 3'),
                ],
              ),
              SeoulButton(
                onPressed: () {},
                style: const SeoulButtonStyle(
                  width: double.infinity,
                  backgroundColor: Colors.teal,
                ),
                child: const Text("Solid button"),
              ),
              SeoulButton(
                disabled: true,
                onPressed: () {},
                style: const SeoulButtonStyle(
                  width: double.infinity,
                  backgroundColor: Colors.teal,
                ),
                child: const Text("Disabled Solid button"),
              ),
              OutlineButton(
                onPressed: () {},
                style: const OutlineButtonStyle(
                  width: double.infinity,
                ),
                child: const Text(
                  "Outline button",
                ),
              ),
              OutlineButton(
                disabled: true,
                onPressed: () {},
                style: const OutlineButtonStyle(
                  width: double.infinity,
                ),
                child: const Text(
                  "Disabled Outline button",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
