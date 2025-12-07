import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/model/memo.dart';
import 'package:nagur/model/system.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = L10n.of(context)!.untitled;
    String content = '';
    ref.watch(systemProvider).whenData((system) {
      ref.watch(memoProvider(system.currentMemoUuid)).whenData((memo) {
        if (memo.title != null) {
          title = memo.title!;
        }
        if (memo.content != null) {
          content = memo.content!;
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        centerTitle: true,
        title: TextFormField(initialValue: title),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_downward)),
          IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: TextFormField(
            decoration: InputDecoration(border: InputBorder.none),
            maxLines: null,
            autofocus: true,
            keyboardType: TextInputType.multiline,
            initialValue: content,
          ),
        ),
      ),
    );
  }
}
