// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryListNotifier)
const historyListProvider = HistoryListNotifierProvider._();

final class HistoryListNotifierProvider
    extends $AsyncNotifierProvider<HistoryListNotifier, List<History>> {
  const HistoryListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyListNotifierHash();

  @$internal
  @override
  HistoryListNotifier create() => HistoryListNotifier();
}

String _$historyListNotifierHash() =>
    r'57fd47f7fd981c2802c9673e69b6846fc7d95195';

abstract class _$HistoryListNotifier extends $AsyncNotifier<List<History>> {
  FutureOr<List<History>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<History>>, List<History>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<History>>, List<History>>,
              AsyncValue<List<History>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
