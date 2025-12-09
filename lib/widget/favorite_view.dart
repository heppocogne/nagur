import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/model/favorite.dart';
import 'package:nagur/model/memo.dart';
import 'package:nagur/model/system.dart';

class FavoriteView extends ConsumerWidget {
  FavoriteView({super.key});

  final formatter = DateFormat('yyyy/MM/dd hh:mm');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(L10n.of(context)!.favorite),
      ),
      body: ref
          .watch(favoriteListProvider)
          .when(
            loading: () => CircularProgressIndicator(),
            data: (list) => ListView(
              children: list.reversed
                  .map<Widget>(
                    (elem) => GestureDetector(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 56,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            elem.title,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Text(formatter.format(elem.updated)),
                                      ],
                                    ),
                                    Text(
                                      elem.content,
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon:
                                    ref.watch(
                                      memoProvider(
                                        elem.uuid,
                                      ).select((s) => s.value!.isFavorite),
                                    )
                                    ? Icon(Icons.star)
                                    : Icon(Icons.star_border),
                                onPressed: () => ref
                                    .read(memoProvider(elem.uuid).notifier)
                                    .toggleFavorite(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        ref
                            .read(systemProvider.notifier)
                            .updateCurrentMemoUuid(elem.uuid);
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                  .toList(),
            ),
            error: (err, _) {
              Logger().e('$err');
              return Center(child: Text('Error loading favorite memo: $err'));
            },
          ),
    );
  }
}
