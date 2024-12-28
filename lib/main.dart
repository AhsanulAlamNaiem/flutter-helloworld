import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List todoList = [
    {"value": "Default task", "isDone": false}
  ];
  String singlevalue = "";

  addString(content) {
    setState(() {
      singlevalue = content;
    });
  }

  addList() {
    setState(() {
      if (singlevalue != "") {
        todoList.add({"value": singlevalue, "isDone": false});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Task should not be empty."),
            duration: Duration(seconds: 1)));
      }
    });
  }

  deleteItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  isChecked(int index, bool? isDone) {
    setState(() {
      todoList[index]["isDone"] = isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PPC Todo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 75,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 90,
              child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Colors.white,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Checkbox(
                                      value: todoList[index]['isDone'],
                                      onChanged: (bool? value) {
                                        isChecked(index, value);
                                      })),
                              Expanded(
                                flex: 60,
                                child: Text(
                                  index.toString() +
                                      ") " +
                                      todoList[index]['value'].toString(),
                                  style: TextStyle(
                                    color: todoList[index]['isDone']
                                        ? Colors.grey
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: TextButton(
                                    onPressed: () {
                                      deleteItem(index);
                                    },
                                    child: Text(
                                      "X",
                                      style: TextStyle(color: Colors.grey),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Container(
                        height: 40,
                        child: TextFormField(
                          onChanged: (content) {
                            addString(content);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              labelText: 'Add Task....',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                          width: 5,
                        )),
                    Expanded(
                        flex: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            addList();
                          },
                          child: Container(
                              height: 15,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("Add")),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
