import 'dart:convert';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'memo.g.dart';

@JsonSerializable()
class Memo {
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? uuid;

  final DateTime updated;
  final String? title;
  final String? content;
  final bool isFavorite;

  Memo({
    this.uuid,
    DateTime? updated,
    this.title,
    this.content,
    this.isFavorite = false,
  }) : updated = updated ?? DateTime.now();

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
  Future<File> _getMemoFile() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}/$uuid.json');
  }

  @override
  Future<Memo> build(String? uuid) async {
    final file = await _getMemoFile();

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty) {
        final json = jsonDecode(jsonString);
        return Memo.fromJson(json).copyWith(uuid: uuid);
      }
    }

    return Memo(uuid: Uuid().v4());
  }

  Future<void> save() async {
    if (state.isLoading || state.hasError) return;
    final currentState = state.requireValue;
    final file = await _getMemoFile();

    final newState = currentState.copyWith(updated: DateTime.now());
    await file.writeAsString(jsonEncode(newState.toJson()));

    state = AsyncData(newState);
  }

  Future<void> updateTitle(String title) async {
    if (state.isLoading || state.hasError) return;

    state = AsyncData(state.requireValue.copyWith(title: title));
    await save();
  }

  Future<void> updateContent(String content) async {
    if (state.isLoading || state.hasError) return;

    state = AsyncData(state.requireValue.copyWith(content: content));
    await save();
  }

  Future<void> toggleFavorite() async {
    if (state.isLoading || state.hasError) return;

    final currentState = state.requireValue;
    state = AsyncData(
      currentState.copyWith(isFavorite: !currentState.isFavorite),
    );
    await save();
  }
}
