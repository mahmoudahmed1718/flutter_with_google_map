import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnakBar({
  required BuildContext context,
  required String message,
}) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(message)));
