import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scaffold Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScaffoldDemoPage(),
    );
  }
}

class ScaffoldDemoPage extends StatefulWidget {
  @override
  _ScaffoldDemoPageState createState() => _ScaffoldDemoPageState();
}

class _ScaffoldDemoPageState extends State<ScaffoldDemoPage> {
  int _counter = 0;
  String _message = "Welcome to Flutter!";

  void _incrementCounter() {
    setState(() {
      _counter++;
      _message = "Button pressed $_counter times!";
    });
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar - Top navigation bar
      appBar: AppBar(
        title: Text('Scaffold Demo'),
        backgroundColor: Colors.blue,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => _showSnackBar('Info button pressed!'),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showSnackBar('Settings button pressed!'),
          ),
        ],
      ),

      // Drawer - Side navigation menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Navigation Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Home selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Profile selected');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Settings selected');
              },
            ),
          ],
        ),
      ),

      // Body - Main content area
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter Scaffold Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),

              Text(
                _message,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              Text(
                'Counter: $_counter',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 30),

              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment Counter'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () => _showSnackBar('Body button pressed!'),
                child: Text('Show SnackBar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              SizedBox(height: 30),

              Text(
                'Try these features:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                '• Tap the menu icon (☰) for drawer\n'
                '• Use the floating action button\n'
                '• Try the app bar action buttons\n'
                '• Tap the bottom navigation tabs',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      // FloatingActionButton - Circular action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter += 5;
            _message = "FloatingActionButton pressed! Added 5 to counter.";
          });
        },
        tooltip: 'Add 5',
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),

      // FloatingActionButton location
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // BottomNavigationBar - Bottom tab navigation
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          List<String> tabs = ['Home', 'Search', 'Favorites', 'Profile'];
          _showSnackBar('${tabs[index]} tab selected');
        },
      ),

      // BottomSheet can be shown programmatically
      // Uncomment to show persistent bottom sheet:
      // persistentFooterButtons: [
      //   TextButton(
      //     onPressed: () => _showSnackBar('Footer button pressed!'),
      //     child: Text('Footer Button'),
      //   ),
      // ],
    );
  }
}
