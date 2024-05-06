import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/event_details.dart';
import 'package:flutter_application_1/styles/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          '5minutflutter',
          style: TextStyle(
            color: AppColors.white
            ),
          ),
        centerTitle: false,
        actions: [
          Icon(Icons.location_on_outlined),
        ],
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"),);
          } else if (data.hasData) {
            var items = data.data as List<EventDetails>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      items[index].eventTitle.toString(),
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    Image.asset("assets/events_resources/images/${items[index].eventPictures?[0]}")
                  ]
                );
              }
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }

  Widget _userItem() {
    return Row(
      children: [
        Image.asset(
          'assets/temp/woman.jpg',
          width: 40,
          height: 40,
        ),
        SizedBox(
          width: 16,
        ),
        Text('Sarah Fernandez')
      ]
    );
  }

  List<Widget> mockUsersFromServer() {
    List<Widget> users = [];
    for (var i = 0; i < 1000; i++) {
      users.add(_userItem());
    }
    return users;
  }

  Future<List<EventDetails>>ReadJsonData() async {
    final jsondata = await rootBundle.loadString('assets/events_resources/json/events_data.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => EventDetails.fromJson(e)).toList();
  }
}