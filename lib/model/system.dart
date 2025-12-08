import 'dart:convert';
import 'dart:io';
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

  SystemState({
    this.currentMemoUuid,
    this.showDeleteConfirmation = true,
    this.isMarkdownView = false,
    required this.language,
    required this.exportLocation,
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
  }) {
    return SystemState(
      currentMemoUuid: currentMemoUuid ?? this.currentMemoUuid,
      showDeleteConfirmation:
          showDeleteConfirmation ?? this.showDeleteConfirmation,
      isMarkdownView: isMarkdownView ?? this.isMarkdownView,
      language: language ?? this.language,
      exportLocation: exportLocation ?? this.exportLocation,
    );
  }
}

@riverpod
class System extends _$System {
  @override
  Future<SystemState> build() async {
    return await _initialize();
  }

  Future<SystemState> _initialize() async {
    state = AsyncValue.loading();

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/system.json');

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty) {
        var system = SystemState.fromJson(jsonDecode(jsonString));
        state = AsyncValue.data(system);
        return system;
      }
    }

    String locale = Platform.localeName;
    String language;
    if (locale.startsWith(Language.ja.name)) {
      language = Language.ja.name;
    } else {
      language = Language.en.name;
    }

    var system = SystemState(
      language: language,
      exportLocation: (await getApplicationDocumentsDirectory()).path,
    );
    state = AsyncValue.data(system);
    return system;
  }

  Future<void> save() async {
    final currentState = await future;

    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/system.json');

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
}
