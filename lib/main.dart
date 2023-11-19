import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadisverse/auth.dart';
import 'package:hadisverse/home.dart';
import 'package:hadisverse/library.dart';
import 'package:hadisverse/profile.dart';
import 'package:hadisverse/search.dart';
import 'package:icons_flutter/icons_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Warna status bar transparan
      statusBarIconBrightness:
          Brightness.dark, // Teks status bar berwarna gelap
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(fontFamily: 'Poppins'),
          headline2: TextStyle(fontFamily: 'Poppins'),
          headline3: TextStyle(fontFamily: 'Poppins'),
          headline4: TextStyle(fontFamily: 'Poppins'),
          headline5: TextStyle(fontFamily: 'Poppins'),
          headline6: TextStyle(fontFamily: 'Poppins'),
          bodyText1: TextStyle(fontFamily: 'Poppins'),
          bodyText2: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  void selectItemBottomNavigationBar(int position) {
    setState(() {
      _currentIndex = position;
    });
  }

  List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      HomePage(selectBNB: selectItemBottomNavigationBar),
      const SearchPage(),
      Container(),
      const LibraryPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "HadisVerse",
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(
        //       AntDesign.bells,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 28,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black45,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (value) {
            if (value != 2) {
              if (value == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthPage(),
                  ),
                );
              }
              setState(() {
                _currentIndex = value;
              });
            }
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(AntDesign.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(AntDesign.search1),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Container(),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(AntDesign.book),
              label: 'Library',
            ),
            const BottomNavigationBarItem(
              icon: Icon(AntDesign.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(AntDesign.scan1),
          ),
        ),
      ),
    );
  }
}
