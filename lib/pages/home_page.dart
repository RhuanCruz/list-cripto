import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/pages/currency_page.dart';
import 'package:flutter_estudo_1/pages/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int atualPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: atualPage);
  }

  setAtualPage(page) {
    setState(() {
      atualPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        // ignore: sort_child_properties_last
        children: const [
          CurrencyPage(),
          FavoritePage(),
        ],
        onPageChanged: setAtualPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        unselectedFontSize: 15,
        unselectedItemColor: const Color.fromARGB(221, 68, 68, 68),
        fixedColor: Colors.white,
        currentIndex: atualPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
        onTap: (page) {
          setState(() {
            pc.animateToPage(page,
                duration: const Duration(milliseconds: 400), curve: Curves.ease);
          });
        },
        backgroundColor: Colors.amber,
      ),
    );
  }
}
