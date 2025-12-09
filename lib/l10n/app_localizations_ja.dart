// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Nagur: 殴り書きメモ帳';

  @override
  String get untitled => '無題';

  @override
  String get deleteConfirmation => 'このメモを削除しますか?';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get favorite => 'お気に入り';

  @override
  String get history => '履歴';

  @override
  String get trashBox => 'ゴミ箱';

  @override
  String get settings => '設定';

  @override
  String get appInformation => 'アプリ情報';

  @override
  String get sourceCode => 'ソースコード:';

  @override
  String get confirmBeforeDelete => '削除前に確認する';

  @override
  String get deletedMemoRetentionDays => '削除されたメモの保存期間:';

  @override
  String get days => '日';

  @override
  String get fontSize => 'フォントサイズ';

  @override
  String get theme => 'テーマ';

  @override
  String get themeModeSystem => 'システムのテーマ';

  @override
  String get themeModeLight => 'ライト';

  @override
  String get themeModeDark => 'ダーク';
}
