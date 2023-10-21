import 'package:flutter/material.dart';

TableRow customTableWidget({
  required String headingText,
  required String dataText,
}) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(headingText),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(dataText),
        ),
      ),
    ],
  );
}
