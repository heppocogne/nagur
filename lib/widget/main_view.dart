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
  Widget build(BuildContext context) {
    AppBar appBar(String? uuid) => AppBar(
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      centerTitle: true,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      title: TextFormField(
        initialValue:
            ref.watch(memoProvider(uuid)).title ?? L10n.of(context)!.untitled,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_downward)), // 仮
        IconButton(
          onPressed: () {},
          icon: Icon(
            ref.watch(memoProvider(uuid)).isFavorite
                ? Icons.star
                : Icons.star_border,
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
      ],
    );

    return ref
        .watch(systemProvider)
        .when(
          data: (SystemState data) => Scaffold(
            appBar: appBar(data.currentMemoUuid),
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
                  initialValue: ref
                      .watch(memoProvider(data.currentMemoUuid))
                      .title,
                ),
              ),
            ),
          ),
          error: (Object error, StackTrace stackTrace) {
            Logger().e('$error\n$stackTrace');
            return Scaffold(appBar: appBar(null));
          },
          loading: () =>
              Scaffold(appBar: appBar(''), body: CircularProgressIndicator()),
        );
  }
}
