import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/utils/localization.dart';
import 'package:flutter_seoul/widgets/common/app_bar.dart';
import 'package:flutter_seoul/widgets/common/button.dart';
import 'package:flutter_seoul/widgets/custom_checkbox.dart';
import 'package:flutter_seoul/widgets/outline_button.dart';

class Sample extends HookWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var agreementValues = useState(List.generate(3, (index) => false));
    var t = localization(context);

    return Scaffold(
      appBar: const AppBarBack(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Button(
                text: t.fullAgreement,
                onPress: () {
                  agreementValues.value =
                      agreementValues.value.map((e) => true).toList();
                },
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: CustomCheckbox(
                      value: agreementValues.value[0],
                      onChanged: (value) {
                        agreementValues.value[0] = value;
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
                      value: agreementValues.value[1],
                      onChanged: (value) {
                        agreementValues.value[1] = value;
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
                      value: agreementValues.value[2],
                      onChanged: (value) {
                        agreementValues.value[2] = value;
                      },
                    ),
                  ),
                  const Text('agreement 3'),
                ],
              ),
              Button(
                text: 'Solid button',
                onPress: () {},
              ),
              Button(
                disabled: true,
                text: 'Disabled Solid button',
                onPress: () {},
              ),
              OutlineButton(
                onPressed: () {},
                style: const OutlineButtonStyle(
                  width: double.infinity,
                ),
                child: const Text(
                  'Outline button',
                ),
              ),
              OutlineButton(
                disabled: true,
                onPressed: () {},
                style: const OutlineButtonStyle(
                  width: double.infinity,
                ),
                child: const Text(
                  'Disabled Outline button',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
