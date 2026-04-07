import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Storage Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  String savedName = "";

  // Save Data
  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", nameController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Data Saved")));
  }

  // Read Data
  readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedName = prefs.getString("name") ?? "No Data Found";

    setState(() {});
  }

  // Update Data
  updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", nameController.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Data Updated")));
  }

  // Delete Data
  deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name");

    setState(() {
      savedName = "";
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Data Deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Local Storage"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveData,
              child: Text("Save Data"),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: readData,
              child: Text("Read Data"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: updateData,
              child: Text("Update Data"),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: deleteData,
              child: Text("Delete Data"),
            ),

            SizedBox(height: 20),

            Text(
              "Stored Data:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              savedName,
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}