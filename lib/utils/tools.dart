import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(),
);

String env(String key) {
  try {
    return dotenv.get(key);
  } on AssertionError catch (e) {
    if (e.message == "A non-null fallback is required for missing entries") {
      logger.e(
        "'$key' Key does not exist. "
        "Make sure that the key exists in the '.env' file.",
      );
    }

    rethrow;
  }
}
