// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nagur: A Scribble Memo Pad';

  @override
  String get untitled => 'Untitled';

  @override
  String get deleteConfirmation => 'Would you like to delete this memo?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get favorite => 'Favorite';

  @override
  String get history => 'History';

  @override
  String get trashBox => 'Trash Box';

  @override
  String get settings => 'Settings';

  @override
  String get appInformation => 'App Information';

  @override
  String get sourceCode => 'Source Code:';

  @override
  String get confirmBeforeDelete =>
      'Show confirmation dialog before delete a memo';

  @override
  String get deletedMemoRetentionDays => 'Deleted memos can be restored for:';

  @override
  String get days => 'Days';

  @override
  String get fontSize => 'Font size';

  @override
  String get theme => 'Theme';

  @override
  String get themeModeSystem => 'Use system theme';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';
}
