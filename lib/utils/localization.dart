import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_seoul/generated/l10n.dart' show S;

S localization(BuildContext context) => S.of(context);

String t(String messageText) => Intl.message(messageText).toString();
