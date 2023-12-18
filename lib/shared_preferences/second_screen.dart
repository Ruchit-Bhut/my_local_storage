import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<String> dataList = [];

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataList = prefs.getStringList('dataList') ?? [];
  }

  Future<void> updateData(int index, String newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataList[index] = newData;
    prefs.setStringList('dataList', dataList);
  }

  Future<void> deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataList.removeAt(index);
    prefs.setStringList('dataList', dataList);
  }

  Future<void> showUpdateDialog(int index) async {
    TextEditingController controller = TextEditingController();

    var updatedData = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Data'),
          content: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter new data',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, '');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim());
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (updatedData.isNotEmpty) {
      await updateData(index, updatedData);
      setState(() {});
    }
  }

  Future<void> showDeleteDialog(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
      await deleteData(index);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Show Data',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: dataList.isEmpty
          ? const Center(
              child: Text(
                'No Data Available',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.black54,
                    title: Text(
                      dataList[index],
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await showUpdateDialog(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await showDeleteDialog(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
