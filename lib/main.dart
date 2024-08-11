import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: TabNavigation(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Screen')),
    );
  }
}

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FirstTab(),
    SecondTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'First Tab',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Second Tab',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('First Tab'));
  }
}

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Second Tab'),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ParentWidget()),
            );
          },
          child: Text('Go to Parent Widget'),
        ),
      ],
    );
  }
}

class ParentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parent')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChildWidget(data: 'Data from Parent'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChildToParentExample()),
              );
            },
            child: Text('Go to Child to Parent Example'),
          ),
        ],
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final String data;

  ChildWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(data),
    );
  }
}

class ChildToParentExample extends StatefulWidget {
  @override
  _ChildToParentExampleState createState() => _ChildToParentExampleState();
}

class _ChildToParentExampleState extends State<ChildToParentExample> {
  String _dataFromChild = '';

  void _updateData(String data) {
    setState(() {
      _dataFromChild = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Child to Parent')),
      body: Column(
        children: [
          ChildWidgetWithCallback(onDataChange: _updateData),
          Text('Data from Child: $_dataFromChild'),
        ],
      ),
    );
  }
}

class ChildWidgetWithCallback extends StatelessWidget {
  final Function(String) onDataChange;

  ChildWidgetWithCallback({required this.onDataChange});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onDataChange('New Data from Child');
      },
      child: Text('Send Data to Parent'),
    );
  }
}
