import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/models.dart';
import '../services/services.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () => Navigator.pushNamed(context, 'userArticles'),
        ),
        title: IconButton(
          icon: const Icon(Icons.monetization_on),
          onPressed: () => Navigator.pushReplacementNamed(context, 'userOrder'),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 158, 125),
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 25, 205, 163),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          LoginServices().logout();
        },
        child: const Icon(Icons.logout),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 222, 222),
      body: productsCompanyService.isLoading
          ? const Center(
              child:
                  SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
          : Column(children: [
              Row(
                children: const [
                  SizedBox(height: 50),
                ],
              ),
              SizedBox(
                  height: 600,
                  width: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 229, 229),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 3,
                              color: const Color.fromARGB(255, 17, 158, 125)),
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
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.only(
                                          right: 20, bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 17, 158, 125)),
                                      ),
                                      child: IconButton(
                                        iconSize: 40,
                                        icon: const Icon(Icons
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
                                    style: const TextStyle(fontSize: 25))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Text(
                                        products[index].compamyDescription,
                                        style: const TextStyle(fontSize: 20))),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Text(products[index].price,
                                        style: const TextStyle(fontSize: 30))),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ))
            ]),
    );
  }
}
