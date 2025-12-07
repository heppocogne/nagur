// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memo _$MemoFromJson(Map<String, dynamic> json) => Memo()
  ..updated = DateTime.parse(json['updated'] as String)
  ..title = json['title'] as String?
  ..content = json['content'] as String?
  ..isFavorite = json['isFavorite'] as bool;

Map<String, dynamic> _$MemoToJson(Memo instance) => <String, dynamic>{
  'updated': instance.updated.toIso8601String(),
  'title': instance.title,
  'content': instance.content,
  'isFavorite': instance.isFavorite,
};
