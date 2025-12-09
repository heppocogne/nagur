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
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$MemoToJson(Memo instance) => <String, dynamic>{
  'updated': instance.updated.toIso8601String(),
  'title': instance.title,
  'content': instance.content,
  'isFavorite': instance.isFavorite,
  'deletedAt': instance.deletedAt?.toIso8601String(),
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MemoNotifier)
const memoProvider = MemoNotifierFamily._();

final class MemoNotifierProvider
    extends $AsyncNotifierProvider<MemoNotifier, Memo> {
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

  @override
  bool operator ==(Object other) {
    return other is MemoNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$memoNotifierHash() => r'07ba2164fd2d0b8e554ceb3366e01038b5aab197';

final class MemoNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MemoNotifier,
          AsyncValue<Memo>,
          Memo,
          FutureOr<Memo>,
          String?
        > {
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

abstract class _$MemoNotifier extends $AsyncNotifier<Memo> {
  late final _$args = ref.$arg as String?;
  String? get uuid => _$args;

  FutureOr<Memo> build(String? uuid);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Memo>, Memo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Memo>, Memo>,
              AsyncValue<Memo>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
