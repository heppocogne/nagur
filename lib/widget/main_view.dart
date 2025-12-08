import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/model/memo.dart';
import 'package:nagur/model/system.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MainViewState();
  }
}

class _MainViewState extends ConsumerState {
  @override
  void initState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ref
        .watch(systemProvider)
        .when(
          data: (SystemState data) {},
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        );
    /*
    String uuid;
    ref.watch(systemProvider).whenData((systemState) async {
      if (systemState.currentMemoUuid == null) {
        uuid = ref.watch(memoProvider(null)).uuid;
        ref.read(systemProvider.notifier).updateCurrentMemoUuid(uuid);
      } else {
        uuid = systemState.currentMemoUuid!;
      }
      Logger().d('uuid=$uuid');
      await ref.watch(memoProvider(uuid).notifier).load();
    });
    */

    /*
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        centerTitle: true,
        title: TextFormField(initialValue: ref.watch(memoProvider())),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_downward)),
          IconButton(
            onPressed: () {},
            icon: Icon(isFavarite ? Icons.star : Icons.star_border),
          ),
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
    */
  }
}
