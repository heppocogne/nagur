import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    AppBar appBar(SystemState? system) => AppBar(
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      centerTitle: true,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      title: TextFormField(
        initialValue: system != null
            ? ref.watch(memoProvider(system.currentMemoUuid)).title ??
                  L10n.of(context)!.untitled
            : L10n.of(context)!.untitled,
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
        IconButton(
          onPressed: () {
            ref.read(systemProvider.notifier).toggleMarkdownView();
          },
          icon: SvgPicture.asset(
            system == null || !system.isMarkdownView
                ? 'assets/markdown_white.svg'
                : 'assets/text_white.svg',
            width: 24,
            height: 24,
          ),
        ),
        IconButton(
          onPressed: () {
            if (system != null) {
              ref
                  .read(memoProvider(system.currentMemoUuid).notifier)
                  .toggleFavorite();
            }
          },
          icon: Icon(
            system != null &&
                    ref.watch(memoProvider(system.currentMemoUuid)).isFavorite
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
            appBar: appBar(data),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            ),
            body: Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: data.isMarkdownView
                    ? MarkdownWidget(
                        markdown: Markdown.fromString(
                          ref
                                  .watch(memoProvider(data.currentMemoUuid))
                                  .content ??
                              '',
                        ),
                      )
                    : TextFormField(
                        onChanged: (text) => ref
                            .read(memoProvider(data.currentMemoUuid).notifier)
                            .updateContent(text),
                        decoration: InputDecoration(border: InputBorder.none),
                        maxLines: null,
                        autofocus: true,
                        keyboardType: TextInputType.multiline,
                        initialValue: ref
                            .watch(memoProvider(data.currentMemoUuid))
                            .content,
                      ),
              ),
            ),
          ),
          error: (Object error, StackTrace stackTrace) {
            Logger().e('$error\n$stackTrace');
            return Scaffold(appBar: appBar(null));
          },
          loading: () =>
              Scaffold(appBar: appBar(null), body: CircularProgressIndicator()),
        );
  }
}
