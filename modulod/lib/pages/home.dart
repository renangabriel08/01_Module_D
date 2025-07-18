import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulod/controllers/app.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  startApp() async {
    String hoteis = await rootBundle.loadString('assets/data/hotels.json');
    String detalhes1000 = await rootBundle.loadString(
      'assets/data/hotels_details1000.json',
    );
    String detalhes1008 = await rootBundle.loadString(
      'assets/data/hotels_details1008.json',
    );

    App.hoteis = jsonDecode(hoteis);
    App.hotel1000 = jsonDecode(detalhes1000);
    App.hotel1008 = jsonDecode(detalhes1008);

    setState(() {});
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Text("The Alps' Hotel"),
            Container(width: 4),
            Image.asset(
              'assets/image/icon/france_national_flag.png',
              height: 36,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/reservas'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: App.hoteis.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: search,
                        keyboardType: TextInputType.webSearch,
                        onChanged: (value) => setState(() {}),
                        decoration: InputDecoration(
                          labelText: 'Search a hotel name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Container(height: 16),
                      for (var hotel in App.hoteis)
                        if (hotel['hotel_name']
                                .toString()
                                .toLowerCase()
                                .contains(search.text.toLowerCase()) ||
                            search.text.isEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: GestureDetector(
                              onTap: () {
                                if (hotel['hotel_id'] == 1000) {
                                  App.hotel = App.hotel1000;
                                  Navigator.pushNamed(context, '/detalhes');
                                } else if (hotel['hotel_id'] == 1008) {
                                  App.hotel = App.hotel1008;
                                  Navigator.pushNamed(context, '/detalhes');
                                }
                              },
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * .2,
                                        height: width * .25,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(10),
                                          child: Image.asset(
                                            'assets/image/${hotel['hotel_cover_image']}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * .4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hotel['hotel_name'],
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                for (
                                                  int i = 0;
                                                  i <
                                                      (hotel['hotel_rating']
                                                                  .toInt() /
                                                              2)
                                                          .toInt();
                                                  i++
                                                )
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 20,
                                                  ),
                                                for (
                                                  int e =
                                                      (hotel['hotel_rating']
                                                                  .toInt() /
                                                              2)
                                                          .toInt();
                                                  e < 5;
                                                  e++
                                                )
                                                  Icon(
                                                    Icons.star_border,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                              ],
                                            ),
                                            Text(
                                              '${hotel['hotel_to_ski_distance']} km from Alps’ ski lift',
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (hotel['hotel_id'] == 1000) {
                                            App.hotel = App.hotel1000;
                                            Navigator.pushNamed(
                                              context,
                                              '/detalhes',
                                            );
                                          } else if (hotel['hotel_id'] ==
                                              1008) {
                                            App.hotel = App.hotel1008;
                                            Navigator.pushNamed(
                                              context,
                                              '/detalhes',
                                            );
                                          }
                                        },
                                        child: Text('Book it'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
