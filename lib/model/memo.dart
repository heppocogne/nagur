import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'memo.g.dart';

@JsonSerializable()
class Memo {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String uuid;

  final DateTime updated;
  final String? title;
  final String? content;
  final bool isFavorite;

  Memo({
    String? uuid,
    DateTime? updated,
    this.title,
    this.content,
    this.isFavorite = false,
  }) : uuid = uuid ?? const Uuid().v4(),
       updated = updated ?? DateTime.now();

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
  Map<String, dynamic> toJson() => _$MemoToJson(this);

  Memo copyWith({
    String? uuid,
    DateTime? updated,
    String? title,
    String? content,
    bool? isFavorite,
  }) {
    return Memo(
      uuid: uuid ?? this.uuid,
      updated: updated ?? this.updated,
      title: title ?? this.title,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@riverpod
class MemoNotifier extends _$MemoNotifier {
  Future<File?> _getMemoFile() async {
    if (uuid != null) {
      final directory = await getApplicationSupportDirectory();
      return File('${directory.path}/$uuid.json');
    } else {
      return null;
    }
  }

  @override
  Memo build(String? uuid) {
    if (uuid != null) {
      return Memo(uuid: uuid);
    } else {
      return Memo(uuid: Uuid().v4());
    }
  }

  Future<String> initialize() async {
    final file = await _getMemoFile();
    if (file != null && await file.exists()) {
      final jsonString = await file.readAsString();
      Logger().d('jsonString=$jsonString');
      if (jsonString.isNotEmpty) {
        final memo = Memo.fromJson(jsonDecode(jsonString));
        state = memo.copyWith(uuid: uuid);
      }
    } else {
      Logger().d('file not found');
      state = state.copyWith(uuid: uuid);
    }

    return state.uuid;
  }

  Future<void> save() async {
    final file = await _getMemoFile();
    if (file != null) {
      state = state.copyWith(updated: DateTime.now());
      await file.writeAsString(jsonEncode(state.toJson()));
    } else {
      Logger().w('file is null, skip saving');
    }
  }

  Future<void> updateTitle(String title) async {
    state = state.copyWith(title: title);
    await save();
  }

  Future<void> updateContent(String content) async {
    state = state.copyWith(content: content);
    await save();
  }

  Future<void> toggleFavorite() async {
    state = state.copyWith(isFavorite: !state.isFavorite);
    await save();
  }
}
