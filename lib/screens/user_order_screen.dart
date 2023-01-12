import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trabajo_flutter/providers/edit_form_provider.dart';
import 'package:trabajo_flutter/providers/user_form_provider.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  List<DataOrders> orders = [];
  final orderService = OrdersServices();

  Future refresh() async {
    setState(() => orders.clear());

    await orderService.loadOrders();

    setState(() {
      orders = orderService.orders;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    Color color;
    Color color2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 158, 125),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: const Color.fromARGB(255, 25, 205, 163),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          LoginServices().logout();
        },
      ),
      backgroundColor: Color.fromARGB(255, 222, 222, 222),
      body: orderService.isLoading
          ? const Center(
              child:
                  SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
          : Column(children: [
              Row(
                children: [
                  SizedBox(height: 50),
                ],
              ),
              SizedBox(
                  height: 600,
                  width: 300,
                  child: Container(
                      child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (DateTime.parse(orders[index].issueDate.toString())
                              .compareTo(date) >
                          0) {
                        color = Colors.red;
                      } else {
                        color = Colors.green;
                      }
                      if (orders[index].invoices == 0) {
                        color2 = Colors.red;
                      } else {
                        color2 = Colors.green;
                      }
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 235, 229, 229),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 3,
                              color: Color.fromARGB(255, 17, 158, 125)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(orders[index].num,
                                        style: TextStyle(fontSize: 25)),
                                    Container(
                                        margin: EdgeInsets.all(10),
                                        child: Text(
                                            orders[index].targetCompanyName,
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(orders[index].createdAt,
                                            style: TextStyle(fontSize: 15))),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(orders[index].issueDate,
                                            style: TextStyle(fontSize: 15))),
                                    Icon(Icons.airport_shuttle_outlined,
                                        color: color, size: 35),
                                    Icon(Icons.assignment,
                                        color: color2, size: 35),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )))
            ]),
    );
  }
}
