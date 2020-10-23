import 'package:flutter/material.dart';
import 'package:imgur/imgur.dart' as imgur;
import '../photoscroll.dart';
import 'ConnectImgur.dart';

/// This is the stateful widget that the main application instantiates.
class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  @override
  _NavBar createState() => _NavBar();
}

var hardCodedURLTestList = [
  'https://i.imgur.com/RUPWLeZ.png',
  'https://i.imgur.com/gSPz2ZM.jpg',
  'https://i.imgur.com/zpcsV3b.jpg',
];

var hardCodedIDsTestList = [
  'RUPWLeZ',
  'gSPz2ZM',
  'zpcsV3b',
];

/// This is the private State class that goes with MyStatefulWidget.
class _NavBar extends State<NavBar> {
  int _selectedIndex = 0;
  Future<List<imgur.Image>> imgurImageList;

  var client;
  var resp;

  Future<List<imgur.Image>> getImgurImages() async {
    debugPrint("Fetching images with token : ");
    debugPrint(authTokenvar);
    client = imgur.Imgur(imgur.Authentication.fromToken(authTokenvar));
    debugPrint('Successfully got Images');
    return resp = await client.account.getImages();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    ScrollCardGallery(hardCodedURLTestList),
    ConnectApp(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      debugPrint('Selected tab:');
      debugPrint(index.toString());
      debugPrint('Token is currently:');
      debugPrint(authTokenvar);
      _selectedIndex = index;
      if (_selectedIndex == 0) imgurImageList = getImgurImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_upload),
            label: 'My Images',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My Images',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'My Images',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
