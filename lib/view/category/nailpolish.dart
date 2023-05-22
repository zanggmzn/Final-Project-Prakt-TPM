// import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projekakhir_prakt/view/category/product_detail.dart';

import '../auth/login_page.dart';

class NailPolishCategory extends StatefulWidget {
  const NailPolishCategory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NailPolishCategoryState createState() => _NailPolishCategoryState();
}

class _NailPolishCategoryState extends State<NailPolishCategory> {
  List home = [];
  bool load = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHome();
  }

  fetchHome() async {
    setState(() {
      load = true;
    });
    var url =
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=revlon&&product_type=nail_polish";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List items = (json.decode(response.body) as List)
          //     // .map((data) => ProductDetail.)
          .toList();

      // var items = json.decode(response.body)['results'];
      setState(() {
        home = items;
        load = false;
      });
    } else {
      setState(() {
        home = [];
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slay Nail",style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 232, 179, 203),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    // ignore: prefer_is_empty
    if (home.contains(null) || home.length < 0 || load) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueGrey),
      ));
    }
    return ListView.builder(
        itemCount: home.length,
        itemBuilder: (context, index) {
          return getCard(home[index]);
        });
  }

  Widget getCard(item) {
    var id = item['id'];
    var title = item['name'];
    var thumbnail = item['image_link'];
    var shortDescription = item['description'];
    var price = item['price'];
    var rating = item['rating'];
    var link = item['product_link'];
    var productType = item['product_type'];
    // var publisher = item['publisher'];

    return Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetail(
                    id: id,
                    title: title,
                    thumbnail: thumbnail,
                    short_description: shortDescription,
                    price: price,
                    rating: rating,
                    link: link,
                    product_type: productType,
                    // genre: genre, platform: platform,publisher: publisher,
                  ))),
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
            padding: const EdgeInsets.all(12),
            child: ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    width: 60,
                    height: 130,
                    thumbnail.toString(),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shop,
                        size: 90,
                      );
                    },
                  )),
              title: Text(
                title.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              subtitle: Text(
                "Price : $price   |   Rating : $rating",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ));
  }
}
