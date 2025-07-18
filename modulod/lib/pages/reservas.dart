import 'package:flutter/material.dart';
import 'package:modulod/controllers/app.dart';

class Reservas extends StatefulWidget {
  const Reservas({super.key});

  @override
  State<Reservas> createState() => _ReservasState();
}

class _ReservasState extends State<Reservas> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
          ),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('My bookings'),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List of my bookings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(height: 8),
                Divider(),
                for (var reserva in App.reservas)
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (App.reservas.indexOf(reserva) + 1).toString(),
                            ),
                            Text(
                              reserva['checkout']['firstName'] +
                                  ' ' +
                                  reserva['checkout']['lastName'],
                            ),
                            Text(reserva['hotel']['hotel_name']),
                            Text(reserva['checkout']['checkin']),
                            Text(reserva['checkout']['checkout']),
                            Text(reserva['checkout']['adults']),
                            Text(reserva['checkout']['children']),
                            Text(reserva['checkout']['rooms']),
                            Text(reserva['checkout']['price']),
                            Text(reserva['checkout']['forBusiness']),
                            Text(reserva['checkout']['pay']),
                          ],
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
