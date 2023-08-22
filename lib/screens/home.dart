import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_personal_directory/db/db.dart';
import 'package:employee_personal_directory/screens/Profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> employees = [];
  List<dynamic> foundUsers = [];
  @override
  void initState() {
    super.initState();
    fetchEmployee();
  }

  void runSearch(String key) {
    List<dynamic> results = [];
    if (key.isEmpty) {
      results = employees;
    } else {
      results = employees
          .where((element) =>
              element['name'].toLowerCase().contains(key.toLowerCase())||element['email'].toLowerCase().contains(key.toLowerCase()))
          .toList();
    }
    setState(() {
      foundUsers=results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title:  Column(
          children: [
            const Text('Employee Directory'),
            TextField(
              onChanged: (value) => runSearch(value),
              decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            )
          ],
        ),
      ),
      body: foundUsers.isNotEmpty
          ? ListView.builder(
              itemCount: foundUsers.length,
              itemBuilder: (context, index) {
                final employee = foundUsers[index];
                print(LocalDataBase().WholeDataList);
                // var decodedResponse = jsonDecode(LocalDataBase().WholeDataList[index]['DummyData']);

                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EmployeeDetails(Employee: employee);
                    }));
                  },
                  leading:
                      // FadeInImage(
                      //     placeholder: const NetworkImage(
                      //         'https://icon-library.com/images/person-image-icon/person-image-icon-18.jpg'),
                      //     image:
                      //         NetworkImage(employee['profile_image'].toString())),
                      Container(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: employee['profile_image'].toString(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                      ),
                    ),
                  ),
                  title: Text(employee['name']),
                  subtitle: Text(employee['email']),
                );
              })
          : const Text(
              'No results found',
              style: TextStyle(fontSize: 25),
            ),
    );
  }

  Future<void> fetchEmployee() async {
    print('Fetching');
    final uri = Uri.parse('https://www.mocky.io/v2/5d565297300000680030a986');

    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    // print(body);
    setState(() {
      employees = json;
      foundUsers=json;
    });
    await LocalDataBase().addDataLocally(wholedata: jsonEncode([employees]));
    // setState(() {});
    await LocalDataBase().readAllData();
    // setState(() {});
    print('Employee fetched');
  }
}
