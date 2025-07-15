import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatefulWidget {
  @override
  _ResponsiveHomePageState createState() => _ResponsiveHomePageState();
}

class _ResponsiveHomePageState extends State<ResponsiveHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomePage(), SearchPage(), ProfilePage()];

  final List<String> _titles = ['Home', 'Search', 'Profile'];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onActionPressed(String action) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$action pressed')));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth >= 768;

        return Scaffold(
          appBar: isTablet
              ? null
              : AppBar(
                  title: Text(_titles[_currentIndex]),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => _onActionPressed('Search'),
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () => _onActionPressed('Notifications'),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => _onActionPressed('Settings'),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () => _onActionPressed('More'),
                    ),
                  ],
                ),
          drawer: isTablet
              ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(color: Colors.blue),
                        child: Text(
                          'Menu',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Search'),
                        onTap: () {
                          Navigator.pop(context);
                          _onActionPressed('Search');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('Notifications'),
                        onTap: () {
                          Navigator.pop(context);
                          _onActionPressed('Notifications');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {
                          Navigator.pop(context);
                          _onActionPressed('Settings');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.more_vert),
                        title: Text('More'),
                        onTap: () {
                          Navigator.pop(context);
                          _onActionPressed('More');
                        },
                      ),
                    ],
                  ),
                )
              : null,
          body: isTablet
              ? Column(
                  children: [
                    // Custom AppBar for tablet
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              icon: Icon(Icons.menu, color: Colors.white),
                              onPressed: () =>
                                  Scaffold.of(context).openDrawer(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _titles[_currentIndex],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: _pages[_currentIndex]),
                  ],
                )
              : _pages[_currentIndex],
          bottomNavigationBar: isTablet
              ? null
              : BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
          floatingActionButton: isTablet
              ? FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildQuickAction(Icons.home, 'Home', 0),
                                _buildQuickAction(Icons.search, 'Search', 1),
                                _buildQuickAction(Icons.person, 'Profile', 2),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }

  Widget _buildQuickAction(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 100, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'Home Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Welcome to the home page!', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 100, color: Colors.green),
          SizedBox(height: 16),
          Text(
            'Search Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Search for anything here!', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 100, color: Colors.orange),
          SizedBox(height: 16),
          Text(
            'Profile Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Your profile information here!',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
