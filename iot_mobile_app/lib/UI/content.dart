import 'package:flutter/material.dart';
import 'package:iot_mobile_app/Models/user.dart';
import 'package:iot_mobile_app/UI/login.dart';
import 'package:json_table/json_table.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  var data;
  var datafromLogin;

  @override
  void initState() {
    super.initState();
    datafromLogin = widget.data;
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 220.0,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nishu (developer)',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Email: nishu@gmail.com',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.yellow),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Phone: +94 11 1234 1234',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.yellow),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Address: 123 Veyangoda, Gampaha',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.yellow),
                        ),
                      ),
                    ],
                  )),
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
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

  getProfileData() async {
    var url = Uri.parse(
        'https://iotattendancesystem.000webhostapp.com/profile.php?APIkey=ndndjdvnvss84d5vdsaf5&fpid=123456789');
    var response = await http.post(url, body: {});

    print(response.statusCode);
    // print(datafromLogin);

    if (response.statusCode == 200) {
      // print(response.body);
      final Map data = jsonDecode(response.body);
      print(data['EmpName']);

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Data'),
        ),
      );
    }
  }
}
