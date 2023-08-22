import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EmployeeDetails extends StatelessWidget {
  final Map Employee;
  const EmployeeDetails({super.key, required this.Employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Employee['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: 170,
                child: CachedNetworkImage(
                  width: 150,
                  height: 200,
                  imageUrl: Employee['profile_image'].toString(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Name  : ${Employee['name']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Username  : ${Employee['username']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email  : ${Employee['email']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Phone  : ${Employee['phone'].toString()}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Website  : ${Employee['website']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Address  : ${Employee['address']['street']},\n${Employee['address']['suite']},\n${Employee['address']['city']},\n${Employee['address']['zipcode']}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Company  : ${Employee['company']['name']},\n${Employee['company']['catchPhrase']},\n${Employee['company']['bs']}',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
