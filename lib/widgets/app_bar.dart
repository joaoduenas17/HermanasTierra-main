import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hdt_flutter/utils/const.dart';

AppBar appBars(BuildContext context, String text) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: principal),
    leadingWidth: 200,
    leading: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
        Text(
          "$text ",
          style: TextStyle(
            color: principal,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
    elevation: 0,
  );
}
