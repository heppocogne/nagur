import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

import 'package:nagur/l10n/app_localizations.dart';
import 'package:nagur/model/trash.dart';
import 'package:nagur/model/memo.dart';

class TrashBoxView extends ConsumerWidget {
  TrashBoxView({super.key});

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
        title: Text(L10n.of(context)!.trashBox),
      ),
      body: ref
          .watch(trashListProvider)
          .when(
            loading: () => CircularProgressIndicator(),
            data: (list) => ListView(
              children: list.reversed
                  .map<Widget>(
                    (elem) => Card(
                      key: ValueKey(elem.uuid),
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
                              icon: Icon(Icons.restore_from_trash_outlined),
                              onPressed: () async {
                                await ref
                                    .read(memoProvider(elem.uuid).notifier)
                                    .restore();
                                ref.invalidate(trashListProvider);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            error: (err, _) {
              Logger().e('$err');
              return Center(child: Text('Error loading trash box: $err'));
            },
          ),
    );
  }
}
