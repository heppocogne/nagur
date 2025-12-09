import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:nagur/model/system.dart';
import 'package:nagur/l10n/app_localizations.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SettingViewState();
  }
}

class _SettingViewState extends ConsumerState<SettingView> {
  late final TextEditingController _daysController;
  late final TextEditingController _fontSizeController;

  @override
  void initState() {
    super.initState();
    _daysController = TextEditingController();
    _fontSizeController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final system = ref.watch(systemProvider).requireValue;
    _daysController.text = system.deletedMemoRetentionDays.toString();
    _fontSizeController.text = system.fontSize.toString();
  }

  @override
  void dispose() {
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(L10n.of(context)!.settings),
      ),
      body: ref
          .watch(systemProvider)
          .when(
            loading: () => CircularProgressIndicator(),
            data: (system) => Container(
              padding: EdgeInsets.all(8),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(L10n.of(context)!.deletedMemoRetentionDays),
                      const Spacer(),
                      SizedBox(
                        width: 64,
                        child: TextField(
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          controller: _daysController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            var n = int.tryParse(value);
                            n = max(n ?? 1, 1);
                            ref
                                .read(systemProvider.notifier)
                                .updateDeletedMemoRetentionDays(n);
                          },
                        ),
                      ),
                      Text(L10n.of(context)!.days),
                    ],
                  ),
                  Row(
                    children: [
                      Text(L10n.of(context)!.confirmBeforeDelete),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: ref
                              .watch(systemProvider)
                              .requireValue
                              .showDeleteConfirmation,
                          onChanged: (_) {
                            ref
                                .read(systemProvider.notifier)
                                .toggleDeleteConfirmation();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(L10n.of(context)!.fontSize),
                      const Spacer(),
                      SizedBox(
                        width: 64,
                        child: TextField(
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          controller: _fontSizeController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                          onChanged: (value) {
                            var n = int.tryParse(value);
                            n = max(n ?? 1, 1);
                            ref.read(systemProvider.notifier).updateFontSize(n);
                          },
                        ),
                      ),
                      const Text('px'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(L10n.of(context)!.theme),
                      const Spacer(),
                      DropdownButton(
                        value: ThemeMode.values.byName(
                          ref.watch(systemProvider).requireValue.themeMode,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text(L10n.of(context)!.themeModeSystem),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text(L10n.of(context)!.themeModeLight),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text(L10n.of(context)!.themeModeDark),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(systemProvider.notifier)
                                .updateThemeMode(value);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            error: (err, _) {
              Logger().e('$err');
              return Center(child: Text('Error loading settings: $err'));
            },
          ),
    );
  }
}
