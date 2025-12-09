import 'package:flutter/material.dart';
//import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/link.dart';

import 'package:nagur/l10n/app_localizations.dart';

class AppInfoView extends StatelessWidget {
  AppInfoView({super.key});

  final repoUrl = 'https://github.com/heppocogne/nagur';
  final rgb0011 = Color.from(red: 0, green: 0, blue: 1.0, alpha: 1.0);

  Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
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
        title: Text(L10n.of(context)!.appInformation),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: getVersion(),
              builder: (context, snapshot) => Text(
                snapshot.hasData ? ('Nagur v${snapshot.data}') : 'Nagur',
              ),
            ),
            Text(L10n.of(context)!.sourceCode),
            Link(
              uri: Uri.parse(repoUrl),
              target: LinkTarget.blank,
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: Text(
                  repoUrl,
                  style: TextStyle(
                    color: rgb0011,
                    decorationColor: rgb0011,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
