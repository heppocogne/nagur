// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

System _$SystemFromJson(Map<String, dynamic> json) => System()
  ..currentMemoUuid = json['currentMemoUuid'] as String?
  ..showDeleteConfirmation = json['showDeleteConfirmation'] as bool
  ..language = json['language'] as String
  ..exportLocation = json['exportLocation'] as String;

Map<String, dynamic> _$SystemToJson(System instance) => <String, dynamic>{
  'currentMemoUuid': instance.currentMemoUuid,
  'showDeleteConfirmation': instance.showDeleteConfirmation,
  'language': instance.language,
  'exportLocation': instance.exportLocation,
};
