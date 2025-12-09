// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trash.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrashListNotifier)
const trashListProvider = TrashListNotifierProvider._();

final class TrashListNotifierProvider
    extends $AsyncNotifierProvider<TrashListNotifier, List<Trash>> {
  const TrashListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trashListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trashListNotifierHash();

  @$internal
  @override
  TrashListNotifier create() => TrashListNotifier();
}

String _$trashListNotifierHash() => r'04b26e37d04279249a02ff2b50f13212375d2fa6';

abstract class _$TrashListNotifier extends $AsyncNotifier<List<Trash>> {
  FutureOr<List<Trash>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Trash>>, List<Trash>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Trash>>, List<Trash>>,
              AsyncValue<List<Trash>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
