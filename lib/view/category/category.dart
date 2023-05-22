import 'package:flutter/material.dart';
import 'package:projekakhir_prakt/view/category/blush.dart';
import 'package:projekakhir_prakt/view/category/foundation.dart';
import 'package:projekakhir_prakt/view/category/lipstick.dart';
import 'package:projekakhir_prakt/view/category/nailpolish.dart';

class Category extends StatefulWidget {
  const Category({Key? key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const CategoryBlush(),
    const LipstickCategory(),
    const FoundationCategory(),
    const NailPolishCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xfff0f1f5),
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255, 164, 89, 123),
          centerTitle: true,
          title: const Text('Revlon Category', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 0, 0, 0),
            isScrollable: true,
            labelColor:Color.fromARGB(255, 255, 255, 255),
            tabs: [
              Tab(text: 'Blush'),
              Tab(text: 'Lipstick'),
              Tab(text: 'Foundation'),
              Tab(text: 'NailPolish'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                const SizedBox(height: 16.0),
                Expanded(
                  child: Row(
                    children: const [
                      Expanded(child: CategoryBlush()),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 16.0),
                Expanded(
                  child: Row(
                    children: const [
                      Expanded(child: LipstickCategory()),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 16.0),
                Expanded(
                  child: Row(
                    children: const [
                      Expanded(child: FoundationCategory()),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 16.0),
                Expanded(
                  child: Row(
                    children: const [
                      Expanded(child: NailPolishCategory()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
