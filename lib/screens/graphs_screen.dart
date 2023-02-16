import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/company_form_provider.dart';
import '../services/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({super.key});

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  List<DataProductsCompany> products = [];
  final productService = ProductsCompanyServices();
  final orderService = OrdersServices();
  int? idTargetCompany;

  bool isSelected = false;
  DateTime now = DateTime.now();

  List<int> sales = [];
  List<DateTime> months = [];
  Future refresh() async {
    setState(() => months.clear());
    setState(() => sales.clear());
    setState(() => products.clear());

    DateTime hace1Mes = DateTime(now.year, now.month - 1, now.day);
    DateTime hace2Mes = DateTime(now.year, now.month - 2, now.day);
    DateTime hace3Mes = DateTime(now.year, now.month - 3, now.day);
    DateTime hace4Mes = DateTime(now.year, now.month - 4, now.day);
    DateTime hace5Mes = DateTime(now.year, now.month - 5, now.day);
    DateTime hace6Mes = DateTime(now.year, now.month - 6, now.day);
    await productService.postProductsCompany();

    idTargetCompany = await UserServices().readIdCompany();
    setState(() {
      print(sales.length);
      months.add(hace1Mes);
      months.add(hace2Mes);
      months.add(hace3Mes);
      months.add(hace4Mes);
      months.add(hace5Mes);
      months.add(hace6Mes);
      products = productService.productsCompany;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final companyForm = Provider.of<CompanyFormProvider>(context);

    refreshProducts(int idProduct) async {
      products.clear();
      await productService.postProductsCompany();
      await orderService.postOrdersCompany(idTargetCompany!, idProduct);
      setState(() {
        // print(products.toString());
        sales = orderService.numOrders;
        isSelected = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'userCompany');
            },
            icon: const Icon(Icons.logout)),
        title: const Text('User Graphs'),
      ),
      body: SizedBox(
          child: Form(
        child: Column(
          children: [
            DropdownButtonFormField(
              hint: const Text(
                'Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              items: products.map((e) {
                /// Ahora creamos "e" y contiene cada uno de los items de la lista.

                return DropdownMenuItem(
                  value: e.articleId,
                  child: Text(e.compamyName.toString(),
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
                    : 'Select a Product';
              },
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
              child: const Text('Submit', style: TextStyle(fontSize: 18)),
            ),
            sales.isEmpty
                ? Container()
                : Visibility(
                    visible: isSelected,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries<SalesData, String>>[
                          LineSeries<SalesData, String>(
                              // Bind data source
                              dataSource: <SalesData>[
                                SalesData(sales[0].toString(), months[0].month),
                                SalesData(sales[1].toString(), months[1].month),
                                SalesData(sales[2].toString(), months[2].month),
                                SalesData(sales[3].toString(), months[3].month),
                                SalesData(sales[4].toString(), months[4].month),
                                SalesData(sales[5].toString(), months[5].month),
                              ],
                              xValueMapper: (SalesData order, _) =>
                                  order.month.toString(),
                              yValueMapper: (SalesData order, _) =>
                                  int.parse(order.sales),
                              name: 'Orders',
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
                  )
          ],
        ),
      )),
    );
  }
}

class SalesData {
  SalesData(this.sales, this.month);
  final int month;
  final String sales;
}
