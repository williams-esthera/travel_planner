import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PlanManagerScreen(title: 'Travel Planner Organizer'),
    );
  }
}

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key, required this.title});

  final String title;

  @override
  State<PlanManagerScreen> createState() => _PlanManagerScreen();
}

class _PlanManagerScreen extends State<PlanManagerScreen> {
  //setting colorscheme
  Color background = Color(0xFFD4E6B5);
  Color background2 = Color(0xFFE2D686);
  Color accent1 = Color(0xFFAFC97E);
  Color accent2 = Color(0xFFFFDF64);
  Color text = Color(0xFF877B66);
  Color text2 = Colors.black;

  //keeps track of what the user types
  final _nameCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _textController = TextEditingController();
  //this list is full of booleans for each task, marking whether the task is completed or not

  DateTime selectedDate = DateTime.now();

  List<Plan> plans = [];
  List<Plan> adoptionPlans = [];
  List<Plan> travelPlans = [];

  String dateToText(DateTime date){
    String stringDate = "${date.year} - ${date.month} - ${date.day}";

    return stringDate;
  }
  //add function, adds plan
  void addPlan() {
    setState(() {
      //if the text field is empty, no task can be created
      if (_textController.text.isNotEmpty) {}
    });
  }

  //deletes tasks once delete button is selected
  void deletePan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Create Plan"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                  builder:
                      (context, setDialogState) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _nameCtrl.clear();
                              _descriptionCtrl.clear();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                        title: const Text('Create Plan'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _nameCtrl,
                                decoration: InputDecoration(
                                  hintText: 'Enter plan name',
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _nameCtrl.clear();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  TextField(
                                    controller: _descriptionCtrl,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 100.0,
                                        horizontal: 10.0,
                                      ),
                                      hintText: 'Enter plan description',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _descriptionCtrl.clear();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                                Text(
                                "Selected Date: ${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  final DateTime? dateTime =
                                      await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(3000),
                                      );
                                  if (dateTime != null) {
                                    setState(() {
                                      selectedDate = dateTime;
                                    });
                                    setDialogState(() {});
                                  }
                                },
                                child: const Text("Choose Date"),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: (){
                                  addPlan();
                                },
                                child: const Text("Create Plan"),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                );
              },
            ),
            Expanded(
              child: ListView.separated(
                itemCount: plans.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      plans[index].name,
                    ),
                    tileColor: accent2,
                    subtitle: Text("${plans[index].description} /n  ${dateToText(plans[index].date)}"),
                  );
                },
                separatorBuilder: 
                (BuildContext context, int index) => 
                  const SizedBox(height:10),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Plan {
  String name;
  String description;
  DateTime date;
  bool isCompleted;

  Plan({
    required this.name,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
}

