import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:json_annotation/json_annotation.dart';

part 'system.g.dart';

enum Language { ja, en }

@JsonSerializable()
class System {
  System();

  String? currentMemoUuid;
  bool showDeleteConfirmation = true;
  bool isMarkdownView = false;
  late String language;
  late String exportLocation;

  factory System.fromJson(Map<String, dynamic> json) => _$SystemFromJson(json);
  Map<String, dynamic> toJson() => _$SystemToJson(this);

  Future<void> save() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/system.json');

    await file.writeAsString(jsonEncode(toJson()));
  }

  Future<void> initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/system.json');

    if (await file.exists()) {
      var system = System.fromJson(jsonDecode(await file.readAsString()));
      currentMemoUuid = system.currentMemoUuid;
      showDeleteConfirmation = system.showDeleteConfirmation;
      isMarkdownView = system.isMarkdownView;
      language = system.language;
      exportLocation = system.exportLocation;
    } else {
      String locale = Platform.localeName;
      if (locale.startsWith(Language.ja.name)) {
        language = Language.ja.name;
      } else {
        language = Language.en.name;
      }
      exportLocation = (await getApplicationDocumentsDirectory()).path;
    }
  }
}

final systemProvider = FutureProvider((ref) async {
  var system = System();
  await system.initialize();

  return system;
});
