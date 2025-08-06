import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayDateConfirmationAlert extends StatelessWidget {
  const DayDateConfirmationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إدخال التاريخ واليوم'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'التاريخ',
                    border: OutlineInputBorder(),
                    hintText: 'مثال: 2025/06/17',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'اليوم',
                    border: OutlineInputBorder(),
                    hintText: 'مثال: الثلاثاء',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              String formattedDate = DateFormat(
                'dd/MM/yyyy, EEEE',
              ).format(DateTime.now());
              log(formattedDate); // e.g., 31/07/2025, Thursday
            },
            child: const Text('استعمل تاريخ اليوم والوقت الحالي!'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('موافق'),
          onPressed: () {
            Navigator.pop(context);
            ;
          },
        ),
      ],
    );
  }
}
