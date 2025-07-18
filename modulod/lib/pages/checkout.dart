import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modulod/controllers/app.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController checkin = TextEditingController();
  TextEditingController checkout = TextEditingController();
  TextEditingController adults = TextEditingController();
  TextEditingController children = TextEditingController();
  TextEditingController rooms = TextEditingController();
  TextEditingController price = TextEditingController();

  String forBusiness = '';
  String pay = '';

  var formKey = GlobalKey<FormState>();

  DateTime checkinDate = DateTime.now();
  DateTime checkoutDate = DateTime.now();

  cadastrar() {
    if (formKey.currentState!.validate() && pay.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Confirmar reserva?'),
          content: SingleChildScrollView(
            child: Text('Deseja confirmar sua reserva.'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                App.reservas.add({
                  'hotel': App.hotel,
                  'quarto': App.quarto,
                  'checkout': {
                    'firstName': firstName.text,
                    'lastName': lastName.text,
                    'checkin': checkin.text,
                    'checkout': checkout.text,
                    'adults': adults.text,
                    'children': children.text,
                    'rooms': rooms.text,
                    'price': price.text,
                    'forBusiness': forBusiness,
                    'pay': pay,
                  },
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reserva confirmada com sucesso!')),
                );

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/reservas',
                  (route) => false,
                );
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Erro ao realizar reserva'),
          content: SingleChildScrollView(
            child: Text('Preencha todos os campos corretamente.'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    adults.text = '1';
    children.text = '0';
    rooms.text = '1';
    price.text =
        "€ ${App.quarto['room_price_for_one_night'] * int.parse(rooms.text)}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Booking Confirm'),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You are going to reserve:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 8),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      App.hotel['hotel_name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                    ),
                    child: ListTile(
                      title: Text(App.quarto['room_type']),
                      subtitle: Text(
                        "Bed: ${App.quarto['room_bed_type']} - Total number of guests: ${App.quarto['room_total_number_of_guests']}",
                      ),
                      trailing: Text(
                        "€ ${App.quarto['room_price_for_one_night']}",
                      ),
                    ),
                  ),

                  Container(height: 20),
                  Divider(),
                  Container(height: 24),
                  Text(
                    'Form',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 16),
                  TextFormField(
                    key: const Key('nome'),
                    onChanged: (value) => setState(() {}),
                    controller: firstName,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      if (value.length > 15) {
                        return 'No máximo 15 caracteres';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(height: 16),
                  TextFormField(
                    key: const Key('sobrenome'),
                    onChanged: (value) => setState(() {}),
                    controller: lastName,

                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      if (value.length > 15) {
                        return 'No máximo 15 caracteres';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(height: 16),
                  TextFormField(
                    key: const Key('checkin'),
                    onChanged: (value) => setState(() {}),
                    controller: checkin,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      return null;
                    },

                    onTap: () =>
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                        ).then((value) {
                          if (value != null) {
                            checkinDate = value;
                            checkin.text = DateFormat(
                              "dd/MM/yyyy",
                            ).format(value);
                          }

                          setState(() {});
                        }),
                    decoration: InputDecoration(
                      labelText: 'Check-in date',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(height: 16),
                  TextFormField(
                    key: const Key('checkout'),
                    enabled: checkin.text.isNotEmpty,
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: checkout,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      if (checkinDate.isAfter(checkoutDate)) {
                        return 'Checkout deve ser após checkin';
                      }

                      return null;
                    },

                    onTap: () =>
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                        ).then((value) {
                          if (value != null) {
                            checkoutDate = value;
                            checkout.text = DateFormat(
                              "dd/MM/yyyy",
                            ).format(value);

                            if (checkout.text == '10/02/2024') {
                              checkout.text = '2024/2/10';
                            }

                            if (checkoutDate.difference(checkinDate).inDays >
                                0) {
                              price.text = price.text =
                                  "€ ${(int.parse(rooms.text).toInt() * App.quarto['room_price_for_one_night']) * checkoutDate.difference(checkinDate).inDays}";
                            }
                          }

                          setState(() {});
                        }),
                    decoration: InputDecoration(
                      labelText: 'Check-ou date',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(height: 16),
                  TextFormField(
                    key: const Key('adultos'),
                    onChanged: (value) {
                      if (adults.text.isNotEmpty && children.text.isNotEmpty) {
                        rooms.text =
                            ((int.parse(adults.text) +
                                        int.parse(children.text)) /
                                    App.quarto['room_total_number_of_guests'])
                                .ceilToDouble()
                                .toInt()
                                .toString();

                        if (checkin.text.isNotEmpty &&
                            checkout.text.isNotEmpty &&
                            checkoutDate.difference(checkinDate).inDays > 0) {
                          price.text =
                              "€ ${(int.parse(rooms.text).toInt() * App.quarto['room_price_for_one_night']) * checkoutDate.difference(checkinDate).inDays}";
                        } else {
                          price.text =
                              "€ ${(int.parse(rooms.text).toInt() * App.quarto['room_price_for_one_night'])}";
                        }
                      }

                      setState(() {});
                    },
                    controller: adults,

                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      if (int.parse(value) > 5) {
                        return 'No máximo 5 adultos';
                      }

                      if (int.parse(value) < 1) {
                        return 'No minimo 1 adulto';
                      }

                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Adults',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(height: 16),
                  TextFormField(
                    key: const Key('criancas'),
                    onChanged: (value) {
                      if (adults.text.isNotEmpty && children.text.isNotEmpty) {
                        rooms.text =
                            ((int.parse(adults.text) +
                                        int.parse(children.text)) /
                                    App.quarto['room_total_number_of_guests'])
                                .ceilToDouble()
                                .toInt()
                                .toString();

                        if (checkin.text.isNotEmpty &&
                            checkout.text.isNotEmpty &&
                            checkoutDate.difference(checkinDate).inDays > 0) {
                          price.text =
                              "€ ${(int.parse(rooms.text).toInt() * App.quarto['room_price_for_one_night']) * checkoutDate.difference(checkinDate).inDays}";
                        } else {
                          price.text =
                              "€ ${(int.parse(rooms.text).toInt() * App.quarto['room_price_for_one_night'])}";
                        }
                      }

                      setState(() {});
                    },
                    controller: children,
                    enabled: adults.text.isNotEmpty,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      if (adults.text.isNotEmpty &&
                          int.parse(value) > int.parse(adults.text) * 2) {
                        return 'No máximo ${int.parse(adults.text) * 2} crianças';
                      }

                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Children',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  Container(height: 16),
                  TextFormField(
                    onChanged: (value) => setState(() {}),
                    controller: rooms,
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Rooms',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(height: 16),
                  Text(
                    'Travel for business?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'For sightseeing',
                            groupValue: forBusiness,
                            onChanged: (value) => setState(() {
                              forBusiness = value.toString();
                            }),
                          ),
                          Text(
                            'For sightseeing',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: '+ € 150 For business with a meeting room',
                            groupValue: forBusiness,
                            onChanged: (value) => setState(() {
                              forBusiness = value.toString();
                            }),
                          ),
                          Text(
                            '+ € 150 For business with a meeting room',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 16),
                  Text(
                    'Wich way to pay?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Cash',
                            groupValue: pay,
                            onChanged: (value) => setState(() {
                              pay = value.toString();
                            }),
                          ),
                          Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Credit Card',
                            groupValue: pay,
                            onChanged: (value) => setState(() {
                              pay = value.toString();
                            }),
                          ),
                          Text(
                            'Credit Card',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            key: const Key('E-Pay'),
                            value: 'E-Pay',
                            groupValue: pay,
                            onChanged: (value) => setState(() {
                              pay = value.toString();
                            }),
                          ),
                          Text(
                            'E-Pay',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 16),
                  TextFormField(
                    onChanged: (value) => setState(() {}),
                    controller: price,
                    readOnly: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () => cadastrar(),
                    child: Text(
                      'Book now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
