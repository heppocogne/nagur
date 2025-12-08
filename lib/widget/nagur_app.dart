import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/widget/main_view.dart';
import 'package:nagur/model/system.dart';

class NagurApp extends ConsumerStatefulWidget {
  const NagurApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NagurAppState();
  }
}

class _NagurAppState extends ConsumerState {
  @override
  void initState() {
    super.initState();

    // システムデータ読み込み
    final system = ref.read(systemProvider);
    system.when(
      loading: () {},
      data: (data) {
        Logger().d(data.toJson());
      },
      error: (error, stackTrace) {
        Logger().e('$error\n$stackTrace');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: L10n.of(context)?.appTitle ?? 'Nagur',
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      //locale: Locale('en'),
      home: MainView(),
    );
  }
}
