// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteListNotifier)
const favoriteListProvider = FavoriteListNotifierProvider._();

final class FavoriteListNotifierProvider
    extends $AsyncNotifierProvider<FavoriteListNotifier, List<Favorite>> {
  const FavoriteListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteListNotifierHash();

  @$internal
  @override
  FavoriteListNotifier create() => FavoriteListNotifier();
}

String _$favoriteListNotifierHash() =>
    r'8157c1b68186dfdfbe15e5bd0dfe5eae2afc894b';

abstract class _$FavoriteListNotifier extends $AsyncNotifier<List<Favorite>> {
  FutureOr<List<Favorite>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Favorite>>, List<Favorite>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Favorite>>, List<Favorite>>,
              AsyncValue<List<Favorite>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
