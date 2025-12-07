import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'memo.g.dart';

@JsonSerializable()
class Memo {
  Memo({String? uuid}) {
    this.uuid = uuid ?? Uuid().v4();
    updated = DateTime.now(); // 後で上書きする場合がある
  }

  late DateTime updated;
  String? title;
  String? content;
  bool isFavorite = false;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late String uuid;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isEdited = false;

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
  Map<String, dynamic> toJson() {
    if (isEdited) {
      updated = DateTime.now();
    }

    return _$MemoToJson(this);
  }
}

final memoProvider = FutureProvider.family<Memo, String?>((ref, uuid) async {
  if (uuid != null) {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/$uuid.json');

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty) {
        final json = jsonDecode(jsonString);
        return Memo.fromJson(json as Map<String, dynamic>);
      }
    }
  }

  return Memo(uuid: uuid);
});
