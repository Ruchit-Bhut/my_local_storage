import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_local_storage/shared_preferences/second_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();

  Future<void> saveData(String data) async {
    if (data.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> dataList = prefs.getStringList('dataList') ?? [];
      dataList.add(data);
      prefs.setStringList('dataList', dataList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Please Enter the data',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Some Text',
                labelText: 'Text',
              ),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () async {
                if (name.text.trim().isNotEmpty) {
                  await saveData(name.text.trim());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter valid data'),
                    ),
                  );
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}