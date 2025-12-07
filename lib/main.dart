import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

import 'package:nagur/widget/nagur_app.dart';

void main() {
  // debug
  getApplicationDocumentsDirectory().then((dir) => Logger().d(dir.path));
  getApplicationSupportDirectory().then((dir) => Logger().d(dir.path));

  runApp(const ProviderScope(child: NagurApp()));
}
