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
  List<int> months = [];
  Future refresh() async {
    setState(() => months.clear());
    setState(() => products.clear());
    await productService.postProductsCompany();

    idTargetCompany = await UserServices().readIdCompany();
    setState(() {
      months = orderService.numOrders;
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
                  value: e.id,
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
            months.isEmpty
                ? Container()
                : Visibility(
                    visible: isSelected,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<SalesData, int>>[
                          LineSeries<SalesData, int>(
                            // Bind data source
                            dataSource: <SalesData>[
                              SalesData(1, months[0]),
                              SalesData(2, months[1]),
                              SalesData(3, months[2]),
                              SalesData(4, months[3]),
                              SalesData(5, months[4]),
                              SalesData(6, months[5]),
                            ],
                            xValueMapper: (SalesData order, _) => order.sales,
                            yValueMapper: (SalesData order, _) => order.month,
                          )
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
  final int sales;
}
