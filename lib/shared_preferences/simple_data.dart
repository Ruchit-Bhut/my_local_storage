import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleData extends StatefulWidget {
  const SimpleData({super.key});

  @override
  State<SimpleData> createState() => _SimpleDataState();
}

class _SimpleDataState extends State<SimpleData> {
  String? name;
  double? price;
  int? age;
  bool? male;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('name');
    price = sp.getDouble('price');
    age = sp.getInt('age');
    male = sp.getBool('male');
    setState(() {});
  }

  void setData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('age', 23);
    sp.setDouble('price', 99.99);
    sp.setString('name', 'Ruchit Bhut');
    sp.setBool('male', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Simple Data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setData();
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Column(
        children: [
          Text(
            name.toString(),
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
          Text(
            price.toString(),
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
          Text(
            age.toString(),
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
          Text(
            male.toString(),
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
