import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
//import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:nagur/model/memo.dart';

part 'history.g.dart';

class History {
  final String uuid;
  final String title;
  final String content;
  final DateTime updated;

  History(this.uuid, this.title, this.content, this.updated);
  History copyWith({
    String? uuid,
    String? title,
    String? content,
    DateTime? updated,
  }) {
    return History(
      uuid ?? this.uuid,
      title ?? this.title,
      content ?? this.content,
      updated ?? this.updated,
    );
  }
}

@riverpod
class HistoryListNotifier extends _$HistoryListNotifier {
  @override
  Future<List<History>> build() async {
    var list = <History>[];

    final dir = await getApplicationSupportDirectory();
    final docDir = Directory('${dir.path}/documents');

    if (!await docDir.exists()) {
      return list;
    }

    for (final entry in docDir.listSync()) {
      final file = File(entry.path);
      if (entry is File && entry.path.endsWith('.json')) {
        final jsonString = await file.readAsString();
        if (jsonString.isEmpty) {
          continue;
        }
        final memo = Memo.fromJson(jsonDecode(jsonString));
        if (memo.deletedAt != null) {
          continue;
        }

        final parts = entry.path.split(Platform.isWindows ? '\\' : '/');
        final filename = parts.last;
        final uuid = filename.substring(0, filename.length - 5);

        list.add(
          History(uuid, memo.title ?? '', memo.content ?? '', memo.updated),
        );
      }
    }

    list.sort((a, b) => a.updated.compareTo(b.updated));

    return list;
  }
}
