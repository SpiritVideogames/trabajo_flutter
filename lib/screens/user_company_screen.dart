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

class UserCompanyScreen extends StatefulWidget {
  const UserCompanyScreen({Key? key}) : super(key: key);

  @override
  State<UserCompanyScreen> createState() => _UserCompanyScreenState();
}

class _UserCompanyScreenState extends State<UserCompanyScreen> {
  List<DataProductsCompany> products = [];
  final productsCompanyService = ProductsCompanyServices();

  Future refresh() async {
    setState(() => products.clear());

    await productsCompanyService.postProductsCompany();

    setState(() {
      products = productsCompanyService.productsCompany;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final productDelete = Provider.of<ProductDeleteServices>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: const Color.fromARGB(255, 25, 205, 163),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          LoginServices().logout();
        },
      ),
      backgroundColor: Color.fromARGB(255, 222, 222, 222),
      body: productsCompanyService.isLoading
          ? const Center(
              child:
                  SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
          : Column(children: [
              Row(
                children: [
                  Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 25, 205, 163),
                          style: BorderStyle.solid,
                        ),
                        color: const Color.fromARGB(255, 25, 205, 163),
                      ),
                      height: 90,
                      width: 360,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          const BoxShadow(
                            spreadRadius: 2,
                            color: Colors.white,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          )
                        ],
                        border: Border.all(
                            width: 3, color: Color.fromARGB(255, 17, 158, 125)),
                      ),
                      child: IconButton(
                        color: Color.fromARGB(255, 17, 147, 116),
                        iconSize: 50,
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          Navigator.pushNamed(context, 'userArticles');
                        },
                      ),
                    ),
                  ]),
                  SizedBox(height: 150),
                ],
              ),
              SizedBox(
                  height: 600,
                  width: 300,
                  child: Container(
                      child: Swiper(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    layout: SwiperLayout.STACK,
                    itemWidth: 600,
                    itemHeight: 200,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
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
                                Row(
                                  children: [
                                    Container(
                                      width: 55,
                                      height: 55,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.only(
                                          right: 20, bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 17, 158, 125)),
                                      ),
                                      child: IconButton(
                                        iconSize: 40,
                                        icon: Icon(Icons
                                            .remove_shopping_cart_outlined),
                                        onPressed: () {
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.warning,
                                            title: 'Are you sure?',
                                            text:
                                                "Are you sure you want to delete this product?",
                                            showCancelBtn: true,
                                            confirmBtnColor: Colors.red,
                                            confirmBtnText: 'Delete',
                                            onConfirmBtnTap: () {
                                              productDelete.deleteProductDelete(
                                                  products[index]
                                                      .id
                                                      .toString());
                                              setState(() {
                                                products.removeAt(index);
                                              });

                                              Navigator.pop(context);
                                            },
                                            onCancelBtnTap: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Text(products[index].compamyName,
                                    style: TextStyle(fontSize: 25))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                        products[index].compamyDescription,
                                        style: TextStyle(fontSize: 20))),
                                //Text(articles[index].price,style: TextStyle(fontSize: 40))),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(products[index].price,
                                        style: TextStyle(fontSize: 30))),
                                //Text(products[index].price,style: TextStyle(fontSize: 40))),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )))
            ]),
    );
  }
}
