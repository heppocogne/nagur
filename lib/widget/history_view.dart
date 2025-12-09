import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/model/history.dart';

class HistoryView extends ConsumerWidget {
  HistoryView({super.key});

  final formatter = DateFormat('yyyy/MM/dd hh:mm');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(L10n.of(context)!.history),
      ),
      body: ref
          .watch(historyListProvider)
          .when(
            loading: () => CircularProgressIndicator(),
            data: (list) => ListView(
              children: list.reversed
                  .map<Widget>(
                    (elem) => Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 56,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      elem.title,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
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
                            /*
                            IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {
                                if (ref
                                    .watch(systemProvider)
                                    .asData! // nullにはならない想定
                                    .value
                                    .showDeleteConfirmation) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          L10n.of(context)!.deleteConfirmation,
                                        ),
                                        actions: <Widget>[
                                          OutlinedButton(
                                            child: Text(
                                              L10n.of(context)!.cancel,
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                          FilledButton(
                                            child: Text(
                                              L10n.of(context)!.delete,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              ref
                                                  .read(
                                                    memoProvider(
                                                      elem.uuid,
                                                    ).notifier,
                                                  )
                                                  .delete();

                                              ref.read(historyListProvider);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  ref
                                      .read(memoProvider(elem.uuid).notifier)
                                      .delete();

                                  ref.read(historyListProvider);
                                }
                              },
                            ),
                             */
                          ],
                        ),
                      ),
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
