import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
//import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:nagur/model/memo.dart';

part 'history.g.dart';

class History {
  final String title;
  final String content;
  final DateTime updated;
  final File file;

  History(this.title, this.content, this.updated, this.file);
  History copyWith({
    String? title,
    String? content,
    DateTime? updated,
    File? file,
  }) {
    return History(
      title ?? this.title,
      content ?? this.content,
      updated ?? this.updated,
      file ?? this.file,
    );
  }
}

@riverpod
class HistoryListNotifier extends _$HistoryListNotifier {
  @override
  Future<List<History>> build() async {
    var list = <History>[];

    final dir = await getApplicationSupportDirectory();
    final docDir = Directory('$dir/documents');
    for (final entry in docDir.listSync()) {
      final file = File(entry.path);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final memo = Memo.fromJson(jsonDecode(jsonString));
        list.add(
          History(memo.title ?? '', memo.content ?? '', memo.updated, file),
        );
      }
    }

    list.sort((a, b) => a.updated.compareTo(b.updated));

    return list;
  }
}
