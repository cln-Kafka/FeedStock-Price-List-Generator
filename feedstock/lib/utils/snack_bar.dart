import 'package:flutter/material.dart';

// You can use the `awesome_snackbar_content` package instead.
// Or you can customize the snackbar to your liking.
// Also, it doesn't have to be a function like this.
// You can create a stateless widget for the snackbar directly.

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
