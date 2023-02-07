import 'dart:io';
import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_flutter/providers/company_form_provider.dart';
import 'package:trabajo_flutter/services/productsCompany_services2.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../models/models.dart';
import '../services/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
  DataCompanies dataCompany = DataCompanies();
  final productService = ProductsCompanyServices2();
  final companyService = CompaniesServices();
  int? idTargetCompany;
  int? idCCompany;
  final orderService = OrdersServices();
  late String companySelected;
  bool isSelected = false;
  double precioTotal = 0;
  getPrecio(int cant, double precio) {
    double aux = cant * precio;
    precioTotal += aux;
    return aux;
  }

  Future refresh() async {
    setState(() => products.clear());
    await productService.postProductsCompany();
    idTargetCompany = await UserServices().readIdCompany();
    setState(() {
      listOfCompanies = companyService.companies;

      for (var i in listOfCompanies) {
        if (i.id == idTargetCompany) {
          dataCompany = i;
        }
      }
      listOfCompanies.remove(dataCompany);
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
                        onPressed: () async {
                          String product = '';
                          int vuelta = 0;
                          productsString.forEach(
                            (key, value) {
                              vuelta = vuelta + 1;
                              if (productsString.length > 1) {
                                if (vuelta == 1) {
                                  product = '$product$key,$value';
                                } else {
                                  product = '$product,$key,$value';
                                }
                              } else {
                                product = '$product$key,$value';
                              }
                            },
                          );

                          int num = 0;
                          setState(() {
                            Random random = Random();
                            num = random.nextInt(100);
                            orderService.postOrder(num, date, idTargetCompany!,
                                companyForm.id, product);
                          });

                          DataCompanies dataMyCompany = DataCompanies();
                          for (var i in listOfCompanies) {
                            if (i.id == companyForm.id) {
                              dataMyCompany = i;
                            }
                          }
                          print("Alex tonto");
                          final pdf = pw.Document();
                          pdf.addPage(pw.Page(
                              pageFormat: PdfPageFormat.a4,
                              build: (pw.Context context) {
                                return pw.Column(children: [
                                  pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                  dataCompany.name.toString()),
                                              pw.Text(dataCompany.address
                                                  .toString()),
                                              pw.Text(
                                                  dataCompany.city.toString()),
                                              pw.Text(
                                                  dataCompany.cif.toString()),
                                              pw.Text(
                                                  dataCompany.email.toString()),
                                            ]),
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Row(children: [
                                                pw.Text('PEDIDO Nº: ',
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(num.toString())
                                              ]),
                                              pw.SizedBox(height: 50),
                                              pw.Row(children: [
                                                pw.Text('FECHA: ',
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(date.toString())
                                              ]),
                                            ])
                                      ]),
                                  pw.SizedBox(height: 25),
                                  pw.Row(children: [
                                    pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Row(children: [
                                            pw.Text("DIRECCIÓN DE ENVÍO: ",
                                                style: pw.TextStyle(
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Text(dataMyCompany.address
                                                .toString())
                                          ]),
                                          pw.Row(children: [
                                            pw.Text("TRANSPORTE: ",
                                                style: pw.TextStyle(
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Text("SIN CARGO")
                                          ]),
                                        ])
                                  ]),
                                  pw.SizedBox(height: 20),
                                  pw.Table(
                                      border: pw.TableBorder.all(),
                                      children: [
                                        pw.TableRow(children: [
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text("REF. COD",
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text("DESCRIPCIÓN",
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text("CANTIDAD",
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text("PRECIO",
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text("IMPORTE",
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                        ]),
                                        for (var producto in products)
                                          for (var entry
                                              in productsString.entries)
                                            if (producto.articleId == entry.key)
                                              pw.TableRow(children: [
                                                pw.Column(
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(producto.articleId
                                                          .toString()),
                                                    ]),
                                                pw.Column(
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(producto
                                                          .compamyDescription
                                                          .toString()),
                                                    ]),
                                                pw.Column(
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(productsString[
                                                              producto
                                                                  .articleId] ??
                                                          'Google'),
                                                    ]),
                                                pw.Column(
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(producto.price
                                                          .toString()),
                                                    ]),
                                                pw.Column(
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(getPrecio(
                                                              int.parse(productsString[producto
                                                                      .articleId
                                                                      .toString()] ??
                                                                  "1"),
                                                              double.parse(
                                                                  producto
                                                                      .price))
                                                          .toStringAsFixed(2)),
                                                    ]),
                                              ]),
                                        pw.TableRow(children: [
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text("TOTAL: ",
                                                    style: pw.TextStyle(
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: []),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: []),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: []),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  pw.MainAxisAlignment.center,
                                              children: [
                                                pw.Text(precioTotal.toString()),
                                              ])
                                        ])
                                      ])
                                ]);
                              }));

                          final file = File(
                              "${"/storage/emulated/0/Download/" + "pedido" + num.toString()}.pdf");
                          await file.writeAsBytes(await pdf.save());

                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              text: "Order made successfully",
                              autoCloseDuration:
                                  const Duration(milliseconds: 100));

                          final Email email = Email(
                            body: 'Here is a copy of the order.',
                            subject: 'Order made successfully',
                            recipients: ['ampr2003@gmail.com'],
                            attachmentPaths: [
                              '/storage/emulated/0/Download/pedido$num' ".pdf"
                            ],
                            isHTML: false,
                          );

                          String platformResponse;

                          try {
                            await FlutterEmailSender.send(email);
                            platformResponse = 'success';
                          } catch (error) {
                            platformResponse = error.toString();
                          }

                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(platformResponse),
                            ),
                          );
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
                                    ? SizedBox(
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
                                    : SizedBox(
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
