import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  List<Widget> widgets = [];
  List<DataProducts> products = [];
  final productsCompanyService = ProductsCompanyServices();

  Future refresh() async {
    setState(() => products.clear());

    final productsCompanyService =
        Provider.of<ProductsCompanyServices>(context, listen: false);

    await productsCompanyService.postProducts();

    setState(() {
      products = productsCompanyService.products;
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
        backgroundColor: Color.fromARGB(255, 189, 183, 183),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: Column(children: [
            Row(
              children: [
                SizedBox(height: 150),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 3, color: Color.fromARGB(255, 17, 158, 125)),
                  ),
                  child: IconButton(
                    color: Color.fromARGB(255, 17, 147, 116),
                    iconSize: 50,
                    icon: Icon(Icons.card_travel_outlined),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 500,
                width: 300,
                child: Container(
                    child: Swiper(
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  layout: SwiperLayout.STACK,
                  itemWidth: 600,
                  itemHeight: 200,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: 200,
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
                                  icon:
                                      Icon(Icons.remove_shopping_cart_outlined),
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
                                  child: Text('40€',
                                      style: TextStyle(fontSize: 40))),
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
