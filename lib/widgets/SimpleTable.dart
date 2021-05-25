import 'package:flutter/material.dart';

class SimpleTable extends StatelessWidget {
  final TableContent tableContent;

  SimpleTable({ this.tableContent });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tableContent.rows.map((row) =>
          Row(children: row.map((col) =>
            Expanded(child: Container(
              child: Center(child: Text('$col')),
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            )),
          ).toList())
      ).toList(),
    );
  }
}

class TableContent {
  final List<List<String>> rows;

  TableContent({ this.rows });
}
