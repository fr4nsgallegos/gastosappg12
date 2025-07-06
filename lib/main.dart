import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gastosappg12/generated/l10n.dart';
import 'package:gastosappg12/pages/examples/db_example.dart';
import 'package:gastosappg12/pages/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      home: HomePage(),
    ),
  );
}
