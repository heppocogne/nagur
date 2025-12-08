// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memo _$MemoFromJson(Map<String, dynamic> json) => Memo(
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
  title: json['title'] as String?,
  content: json['content'] as String?,
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$MemoToJson(Memo instance) => <String, dynamic>{
  'updated': instance.updated.toIso8601String(),
  'title': instance.title,
  'content': instance.content,
  'isFavorite': instance.isFavorite,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MemoNotifier)
const memoProvider = MemoNotifierFamily._();

final class MemoNotifierProvider extends $NotifierProvider<MemoNotifier, Memo> {
  const MemoNotifierProvider._({
    required MemoNotifierFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'memoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$memoNotifierHash();

  @override
  String toString() {
    return r'memoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MemoNotifier create() => MemoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Memo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Memo>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MemoNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memoNotifierHash() => r'c63ff48179fdec78e892d09192280535a53fc41f';

final class MemoNotifierFamily extends $Family
    with $ClassFamilyOverride<MemoNotifier, Memo, Memo, Memo, String?> {
  const MemoNotifierFamily._()
    : super(
        retry: null,
        name: r'memoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MemoNotifierProvider call(String? uuid) =>
      MemoNotifierProvider._(argument: uuid, from: this);

  @override
  String toString() => r'memoProvider';
}

abstract class _$MemoNotifier extends $Notifier<Memo> {
  late final _$args = ref.$arg as String?;
  String? get uuid => _$args;

  Memo build(String? uuid);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<Memo, Memo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Memo, Memo>,
              Memo,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
