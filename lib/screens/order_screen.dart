import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_flutter/providers/company_form_provider.dart';
import 'package:trabajo_flutter/services/productsCompany_services2.dart';

import '../models/models.dart';
import '../services/services.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<DataProductsCompany> products = [];
  List<bool> checks = [];
  List<DataCompanies> listOfCompanies = [];
  Map<int, String> productsString = <int, String>{};

  final productService = ProductsCompanyServices2();
  final companyService = CompaniesServices();
  int? idTargetCompany;
  int? idCCompany;
  final orderService = OrdersServices();
  late String companySelected;
  bool isSelected = false;

  Future refresh() async {
    setState(() => products.clear());
    await productService.postProductsCompany();
    idTargetCompany = await UserServices().readIdCompany();
    setState(() {
      listOfCompanies = companyService.companies;

      products = productService.aux;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    refreshProducts(int value) async {
      products.clear();
      await productService.getProducts(value);
      setState(() {
        products = productService.aux;
        checks = List<bool>.filled(products.length, false);
        // print(products.toString());

        isSelected = true;
      });
    }

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    final companyForm = Provider.of<CompanyFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 158, 125),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'userOrder');
            },
            icon: const Icon(Icons.logout)),
      ),
      backgroundColor: const Color.fromARGB(255, 222, 222, 222),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Form(
            key: companyForm.formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  hint: const Text(
                    'Company',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  items: listOfCompanies.map((e) {
                    /// Ahora creamos "e" y contiene cada uno de los items de la lista.

                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 18, 201, 159))),
                    );
                  }).toList(),
                  onChanged: (value) {
                    companyForm.id = value!;
                  },
                  validator: (value) {
                    return (value != null && value != 0)
                        ? null
                        : 'Select a Company';
                  },
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 18, 201, 159))),
                      onPressed: () {
                        setState(() {
                          refreshProducts(companyForm.id);
                        });
                      },
                      child:
                          const Text('Submit', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: isSelected,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 18, 201, 159))),
                        onPressed: () {
                          String product = '';
                          print(productsString);
                          int vuelta = 0;
                          productsString.forEach(
                            (key, value) {
                              vuelta = vuelta + 1;
                              if (productsString.length > 1) {
                                if (vuelta == 1) {
                                  product = product + '$key' + ',' + value;
                                } else {
                                  product =
                                      product + ',' + '$key' + ',' + value;
                                }
                              } else {
                                product = product + '$key' + ',' + value;
                              }
                            },
                          );

                          print(product);
                          setState(() {
                            Random random = Random();
                            int num = random.nextInt(100);
                            orderService.postOrder(num, date, idTargetCompany!,
                                companyForm.id, product);
                          });

                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              text: "Order made successfully",
                              autoCloseDuration:
                                  const Duration(milliseconds: 100));
                        },
                        child: const Text('Make Order',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isSelected,
          child: SizedBox(
              height: 580,
              width: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  double cant = 0;
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
                            Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                value: checks[index],
                                onChanged: ((value) {
                                  setState(() {
                                    if (value == true) {
                                      final p = <int, String>{
                                        products[index].articleId: '$cant'
                                      };
                                      productsString.addEntries(p.entries);

                                      checks[index] = value!;
                                    } else {
                                      productsString
                                          .remove(products[index].articleId);

                                      checks[index] = value!;
                                    }
                                  });
                                })),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                checks[index]
                                    ? Container(
                                        width: 150,
                                        child: SpinBox(
                                            decimals: 0,
                                            showButtons: checks[index],
                                            step: 1,
                                            min: 1,
                                            max: 40,
                                            value: cant,
                                            readOnly: true,
                                            onChanged: ((value) {
                                              cant = value;
                                              productsString.update(
                                                  products[index].articleId,
                                                  (value) => '$cant');
                                            })),
                                      )
                                    : Container(
                                        width: 100,
                                        child: SpinBox(
                                            decimals: 0,
                                            showButtons: checks[index],
                                            step: 1,
                                            min: 1,
                                            max: 40,
                                            value: cant,
                                            readOnly: true,
                                            onChanged: ((value) {
                                              cant = value;
                                            })),
                                      ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                    margin: const EdgeInsets.all(5),
                                    child: Text(
                                        products[index].compamyDescription,
                                        style: const TextStyle(fontSize: 18))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )),
        )
      ]),
    );
  }
}
