import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system.g.dart';

enum Language { ja, en }

@JsonSerializable()
class SystemState {
  final String? currentMemoUuid;
  final bool showDeleteConfirmation;
  final bool isMarkdownView;
  final String language;
  final String exportLocation;
  final int deletedMemoRetentionDays;

  SystemState({
    this.currentMemoUuid,
    this.showDeleteConfirmation = true,
    this.isMarkdownView = false,
    required this.language,
    required this.exportLocation,
    this.deletedMemoRetentionDays = 30,
  });

  factory SystemState.fromJson(Map<String, dynamic> json) =>
      _$SystemStateFromJson(json);
  Map<String, dynamic> toJson() => _$SystemStateToJson(this);

  SystemState copyWith({
    String? currentMemoUuid,
    bool? showDeleteConfirmation,
    bool? isMarkdownView,
    String? language,
    String? exportLocation,
    int? deletedMemoRetentionDays,
  }) {
    return SystemState(
      currentMemoUuid: currentMemoUuid ?? this.currentMemoUuid,
      showDeleteConfirmation:
          showDeleteConfirmation ?? this.showDeleteConfirmation,
      isMarkdownView: isMarkdownView ?? this.isMarkdownView,
      language: language ?? this.language,
      exportLocation: exportLocation ?? this.exportLocation,
      deletedMemoRetentionDays:
          deletedMemoRetentionDays ?? this.deletedMemoRetentionDays,
    );
  }
}

@riverpod
class System extends _$System {
  @override
  Future<SystemState> build() async {
    state = const AsyncValue.loading();

    SystemState system;
    final file = await _getSystemFile();
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty) {
        system = SystemState.fromJson(jsonDecode(jsonString));
      } else {
        system = await _createDefaultSystemState();
      }
    } else {
      system = await _createDefaultSystemState();
    }

    await _cleanupDeletedMemos(system.deletedMemoRetentionDays);

    state = AsyncValue.data(system);
    return system;
  }

  static Future<File> _getSystemFile() async {
    final directory = await getApplicationSupportDirectory();
    return File('${directory.path}/system.json');
  }

  Future<void> save() async {
    final currentState = await future;
    final file = await _getSystemFile();

    await file.writeAsString(jsonEncode(currentState.toJson()), flush: true);
  }

  Future<void> updateCurrentMemoUuid(String? uuid) async {
    final currentState = await future;

    state = AsyncValue.data(currentState.copyWith(currentMemoUuid: uuid));
    await save();
  }

  Future<void> toggleDeleteConfirmation() async {
    final currentState = await future;

    state = AsyncValue.data(
      currentState.copyWith(
        showDeleteConfirmation: !currentState.showDeleteConfirmation,
      ),
    );
    await save();
  }

  Future<void> toggleMarkdownView() async {
    final currentState = await future;
    state = AsyncValue.data(
      currentState.copyWith(isMarkdownView: !currentState.isMarkdownView),
    );
    await save();
  }

  Future<SystemState> _createDefaultSystemState() async {
    String locale = Platform.localeName;
    String language;
    if (locale.startsWith(Language.ja.name)) {
      language = Language.ja.name;
    } else {
      language = Language.en.name;
    }

    return SystemState(
      language: language,
      exportLocation: (await getApplicationDocumentsDirectory()).path,
    );
  }

  Future<void> _cleanupDeletedMemos(int retentionDays) async {
    final dir = await getApplicationSupportDirectory();
    final docDir = Directory('${dir.path}/documents');

    if (!await docDir.exists()) {
      return;
    }

    final threshold = DateTime.now().subtract(Duration(days: retentionDays));

    for (final entry in docDir.listSync()) {
      if (entry is File && entry.path.endsWith('.json')) {
        final file = File(entry.path);
        try {
          final jsonString = await file.readAsString();
          if (jsonString.isEmpty) {
            continue;
          }
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          if (json.containsKey('deletedAt') && json['deletedAt'] != null) {
            final deletedAt = DateTime.parse(json['deletedAt'] as String);
            if (deletedAt.isBefore(threshold)) {
              await file.delete();
              Logger().i('Memo deleted: ${file.path}');
            }
          }
        } catch (e) {
          Logger().e('Error on deleting ${file.path}: $e');
        }
      }
    }
  }
}
