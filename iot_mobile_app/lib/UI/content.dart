import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';

class Content extends StatefulWidget {
  var data;

  Content(data) {
    this.data = data;
  }

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  var columns = [
    JsonTableColumn("LogID", label: "LogID"),
    JsonTableColumn("Date", label: "Date"),
    JsonTableColumn("Time", label: "Time"),
    JsonTableColumn("Temperature", label: "Temperature"),
    JsonTableColumn("TempStatus", label: "Temp Status"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            JsonTable(widget.data, columns: columns),
          ],
        ),
      ),
    );
  }
}
