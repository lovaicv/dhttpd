import 'dart:io';

import 'package:dhttpd/dhttpd.dart';
import 'package:dhttpd/src/options.dart';

Future<void> main(List<String> args) async {
  Options options;
  try {
    options = parseOptions(args);
  } on FormatException catch (e) {
    stderr.writeln(e.message);
    print(usage);
    exitCode = 64;
    return;
  }

  if (options.help) {
    print(usage);
    return;
  }

  String? port = Platform.environment['PORT'];
  print('Platform.environment PORT is ${port}');
  int? herokuPort = int.tryParse(port!);
  print('herokuPort is ${port}');

  await Dhttpd.start(path: options.path, port: herokuPort ?? 8080, address: options.host);

  print('Server started on port ${herokuPort ?? 8080}');
}
