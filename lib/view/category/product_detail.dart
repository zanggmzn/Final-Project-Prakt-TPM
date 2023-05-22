import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatelessWidget {
  int id;
  String title;
  String thumbnail;
  String short_description;
  String price;
  double rating;
  String link;
  String product_type;

  ProductDetail({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.short_description,
    required this.price,
    required this.rating,
    required this.link,
    required this.product_type,
  });

  final Uri _url = Uri.parse('https://flutter.dev');
  //

  Future<void> goToWebPage(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xfff0f1f5),
        appBar: AppBar(
            title: Text(title.toString()),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    await goToWebPage(link.toString());
                  },
                  icon: Icon(Icons.search, color: Colors.white)),
            ],
            backgroundColor: Color.fromARGB(255, 164, 89, 123)),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(18),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.2,
                child: Image.network(
                  width: 60,
                  height: 130,
                  thumbnail.toString(),
                  fit: BoxFit.fill,
                ),
              ),
              Card(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Produk: $title",
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Harga: $price",
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Rating: $rating",
                              style: TextStyle(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.10),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        short_description.toString(),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          wordSpacing: 3,
                        ),
                        maxLines: 11,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
