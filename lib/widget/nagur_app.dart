import 'package:flutter/material.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/widget/main_view.dart';

class NagurApp extends StatelessWidget {
  const NagurApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: L10n.of(context)?.appTitle ?? 'Nagur',
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      //locale: Locale('en'),
      home: const MainView(),
    );
  }
}
