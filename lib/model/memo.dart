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
  Future<File> _getMemoFile(String uuid) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$uuid.json');
  }

  @override
  Memo build(String? uuid) {
    if (uuid != null) {
      return Memo(uuid: uuid);
    } else {
      return Memo(uuid: Uuid().v4());
    }
  }

  Future<void> load() async {
    if (uuid != null) {
      final file = await _getMemoFile(uuid!);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        if (jsonString.isNotEmpty) {
          state = Memo.fromJson(jsonDecode(jsonString));
          return;
        }
      }
    }

    state = Memo(uuid: Uuid().v4());
  }

  Future<void> save() async {
    final memo = state.copyWith(updated: DateTime.now());
    final file = await _getMemoFile(state.uuid);
    await file.writeAsString(jsonEncode(memo.toJson()));

    state = memo;
  }

  void updateUuid(String uuid) {
    state = state.copyWith(uuid: uuid);
    return;
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
