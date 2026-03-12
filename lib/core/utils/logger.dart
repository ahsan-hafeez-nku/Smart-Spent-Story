import 'package:logger/logger.dart' as pkg;

final logger = pkg.Logger(
  printer: pkg.PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
  ),
);
