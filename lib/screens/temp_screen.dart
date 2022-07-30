import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/utils/tools.dart';
import 'package:flutter_boilerplate/widgets/outline_button.dart';
import 'package:flutter_boilerplate/screens/sign_up_screen/agreement_checkbox.dart';
import 'package:flutter_boilerplate/widgets/solid_button.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  List<bool> _agreementValues = List.generate(4, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SolidButton(
                onPressed: () {
                  setState(() {
                    _agreementValues =
                        _agreementValues.map((e) => true).toList();
                    logger.d(_agreementValues);
                  });
                },
                style: const SolidButtonStyle(
                  width: double.infinity,
                  height: 50,
                ),
                child: const Text("All agree"),
              ),
              Row(
                children: [
                  AgreementCheckbox(
                    value: _agreementValues[0],
                    onChanged: (value) {
                      _agreementValues[0] = value;
                    },
                  ),
                  const Text('agreement 1'),
                ],
              ),
              Row(
                children: [
                  AgreementCheckbox(
                    value: _agreementValues[1],
                    onChanged: (value) {
                      _agreementValues[1] = value;
                    },
                  ),
                  const Text('agreement 2'),
                ],
              ),
              Row(
                children: [
                  AgreementCheckbox(
                    value: _agreementValues[2],
                    onChanged: (value) {
                      _agreementValues[2] = value;
                    },
                  ),
                  const Text('agreement 3'),
                ],
              ),
              Row(
                children: [
                  AgreementCheckbox(
                    value: _agreementValues[3],
                    onChanged: (value) {
                      _agreementValues[3] = value;
                    },
                  ),
                  const Text('agreement 4'),
                ],
              ),
              SolidButton(
                onPressed: () {},
                style: const SolidButtonStyle(
                  width: double.infinity,
                  backgroundColor: Colors.teal,
                ),
                child: const Text("Solid button"),
              ),
              SolidButton(
                disabled: true,
                onPressed: () {},
                style: const SolidButtonStyle(
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
