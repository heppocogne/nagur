// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemState _$SystemStateFromJson(Map<String, dynamic> json) => SystemState(
  currentMemoUuid: json['currentMemoUuid'] as String?,
  showDeleteConfirmation: json['showDeleteConfirmation'] as bool? ?? true,
  isMarkdownView: json['isMarkdownView'] as bool? ?? false,
  language: json['language'] as String,
  exportLocation: json['exportLocation'] as String,
);

Map<String, dynamic> _$SystemStateToJson(SystemState instance) =>
    <String, dynamic>{
      'currentMemoUuid': instance.currentMemoUuid,
      'showDeleteConfirmation': instance.showDeleteConfirmation,
      'isMarkdownView': instance.isMarkdownView,
      'language': instance.language,
      'exportLocation': instance.exportLocation,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(System)
const systemProvider = SystemProvider._();

final class SystemProvider extends $AsyncNotifierProvider<System, SystemState> {
  const SystemProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemHash();

  @$internal
  @override
  System create() => System();
}

String _$systemHash() => r'77535bea002d848b1da8a74951980c88a169a5bb';

abstract class _$System extends $AsyncNotifier<SystemState> {
  FutureOr<SystemState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SystemState>, SystemState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SystemState>, SystemState>,
              AsyncValue<SystemState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
