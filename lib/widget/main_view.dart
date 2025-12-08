import 'package:flutter/material.dart';
import 'package:flutter_md/flutter_md.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import 'package:nagur/model/memo.dart';
import 'package:nagur/model/system.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemAsync = ref.watch(systemProvider);

    return systemAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) {
        Logger().e('$err\n$stack');
        return Scaffold(body: Center(child: Text('Error: $err')));
      },
      data: (system) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              // TODO: 実装する
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            title: MemoTitle(uuid: system.currentMemoUuid),
            centerTitle: true,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  ref.read(systemProvider.notifier).toggleMarkdownView();
                },
                icon: SvgPicture.asset(
                  !system.isMarkdownView
                      ? 'assets/markdown_white.svg'
                      : 'assets/text_white.svg',
                  width: 24,
                  height: 24,
                ),
              ),
              MemoFavoriteButton(uuid: system.currentMemoUuid),
              IconButton(
                // TODO: 実装する
                onPressed: () {},
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            // TODO: 実装する
            onPressed: () {},
            child: Icon(Icons.add),
          ),
          body: MemoEditor(
            key: ValueKey(system.currentMemoUuid),
            uuid: system.currentMemoUuid,
          ),
        );
      },
    );
  }
}

class MemoTitle extends ConsumerStatefulWidget {
  final String? uuid;
  const MemoTitle({super.key, this.uuid});

  @override
  ConsumerState<MemoTitle> createState() => _MemoTitleState();
}

class _MemoTitleState extends ConsumerState<MemoTitle> {
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      memoProvider(widget.uuid).select((asyncValue) => asyncValue.value?.title),
      (previous, next) {
        if (next != null && next != _titleController.text) {
          _titleController.text = next;
        }
      },
    );

    return TextField(
      controller: _titleController,
      onChanged: (value) =>
          ref.read(memoProvider(widget.uuid).notifier).updateTitle(value),
      style: const TextStyle(color: Colors.white, fontSize: 20),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
        border: InputBorder.none,
      ),
    );
  }
}

class MemoFavoriteButton extends ConsumerWidget {
  final String? uuid;
  const MemoFavoriteButton({super.key, required this.uuid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(memoProvider(uuid).select((m) => m.value?.isFavorite)) ??
        false;

    return IconButton(
      onPressed: () {
        ref.read(memoProvider(uuid).notifier).toggleFavorite();
      },
      icon: Icon(isFavorite ? Icons.star : Icons.star_border),
    );
  }
}

class MemoEditor extends ConsumerStatefulWidget {
  final String? uuid;
  const MemoEditor({super.key, required this.uuid});

  @override
  ConsumerState<MemoEditor> createState() => _MemoEditorState();
}

class _MemoEditorState extends ConsumerState<MemoEditor> {
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final memoAsync = ref.watch(memoProvider(widget.uuid));

    ref.listen(
      memoProvider(
        widget.uuid,
      ).select((asyncValue) => asyncValue.value?.content),
      (previous, next) {
        if (next != null && next != _contentController.text) {
          _contentController.text = next;
        }
      },
    );

    return memoAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        Logger().e('$err\n$stack');
        return Center(child: Text('Error loading memo: $err'));
      },
      data: (memo) {
        final isMarkdownView =
            ref.watch(systemProvider.select((s) => s.value?.isMarkdownView)) ??
            false;

        if (isMarkdownView) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: MarkdownWidget(
              markdown: Markdown.fromString(memo.content ?? ''),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _contentController,
            onChanged: (text) => ref
                .read(memoProvider(widget.uuid).notifier)
                .updateContent(text),
            decoration: const InputDecoration(border: InputBorder.none),
            maxLines: null,
            autofocus: true,
            expands: true,
            keyboardType: TextInputType.multiline,
          ),
        );
      },
    );
  }
}
