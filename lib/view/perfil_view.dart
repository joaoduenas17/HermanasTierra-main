import 'package:flutter/material.dart';
import 'package:hdt_flutter/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(context, AppLocalizations.of(context)!.menu),
      body: Container(
        color: Colors.cyan,
      ),
    );
  }
}
