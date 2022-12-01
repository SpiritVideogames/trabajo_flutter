import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

    final productsCompanyService =
        Provider.of<ProductsCompanyServices>(context, listen: false);

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
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 222, 222, 222),
        body: productsCompanyService.isLoading
            ? const Center(
                child: SpinKitWave(
                    color: Color.fromRGBO(0, 153, 153, 1), size: 50))
            : RefreshIndicator(
                onRefresh: refresh,
                child: Column(children: [
                  Row(
                    children: [
                      Stack(children: [
                        Container(
                          color: Color.fromARGB(255, 25, 205, 163),
                          height: 90,
                          width: 360,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 3,
                                color: Color.fromARGB(255, 17, 158, 125)),
                          ),
                          child: IconButton(
                            color: Color.fromARGB(255, 17, 147, 116),
                            iconSize: 50,
                            icon: Icon(Icons.shopping_cart_outlined),
                            onPressed: () {
                              Navigator.pushNamed(context, 'userCompany');
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
                                        onPressed: () {},
                                      ),
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
              ));
  }

  /*
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 40 / 9,
                    scrollDirection: Axis.vertical,
                  ),
                  items: [1, 2, 3, 4, 5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 3,
                                    color: Color.fromARGB(255, 17, 158, 125)),
                              ),
                              child: Column(
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
                                          icon: Icon(
                                              Icons.add_shopping_cart_outlined),
                                          onPressed: () {},
                                        ),
                                      ),
                                      Text('Producto',
                                          style: TextStyle(fontSize: 40))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(10),
                                          child: Text('40€',
                                              style: TextStyle(fontSize: 40))),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      },
                    );
                  }).toList(),
                ) ListWheelScrollView(itemExtent: 200, children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 800,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 3, color: Color.fromARGB(255, 17, 158, 125)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(right: 20, bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 17, 158, 125)),
                            ),
                            child: IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.add_shopping_cart_outlined),
                              onPressed: () {},
                            ),
                          ),
                          Text('Producto', style: TextStyle(fontSize: 40))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child:
                                  Text('40€', style: TextStyle(fontSize: 40))),
                        ],
                      )
                    ],
                  ),
                )
              ]),*/

}
