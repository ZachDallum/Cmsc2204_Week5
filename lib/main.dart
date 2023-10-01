import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Git Week 6'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItems = false;
  bool itemsLoaded = false;

  List<Customers> customer = [
    Customers('Jim', 'Bob', 101, 'Spender'),
    Customers('Jerry', 'Smith', 102, 'Saver'),
    Customers('Larry', 'Jones', 103, 'Spender'),
    Customers('Terry', 'Sherry', 104, 'Occasional'),
    Customers('Tom', 'Dahl', 105, 'Frequent'),
    Customers('Tim', 'Johnson', 106, 'Frequent'),
    Customers('Peter', 'Williams', 107, 'Saver'),
    Customers('Jesse', 'Poland', 108, 'Occasional'),
    Customers('Dan', 'Holland', 109, 'Saver'),
    Customers('Harry', 'Connelly', 110, 'Spender'),
  ];

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItems = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItems = false;
        itemsLoaded = true;
      });
    });
  }

  void _resetButtonPress() {
    setState(() {
      pageFirstLoad = true;
      itemsLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load Items"),
              )
            : isLoadingItems
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Loading Items")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: customer.map((item) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.FirstName,
                                  style: TextStyle(fontSize: 20)),
                              Text(item.LastName,
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                  'Customer ID: ${item.CustomerID.toString()}'),
                              Text('Buying habbits: ${item.Type}'),
                              Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
      floatingActionButton: itemsLoaded
          ? FloatingActionButton(
              onPressed: _resetButtonPress,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class Customers {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Customers(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
