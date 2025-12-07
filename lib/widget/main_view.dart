import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/model/memo.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        centerTitle: true,
        title: TextFormField(
          initialValue:
              ref.watch(memoProvider('')).title ?? L10n.of(context)!.untitled,
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.delete))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: null,
    );
  }
}
