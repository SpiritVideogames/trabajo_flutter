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
  int? idTargetCompany;
  bool isSelected = false;
  DateTime now = DateTime.now();
  List<int> months = [];
  Future refresh() async {
    months.clear();
    setState(() => products.clear());
    await productService.postProductsCompany();

    idTargetCompany = await UserServices().readIdCompany();
    setState(() {
      for (int i = 1; i <= 6; i++) {
        months.add(now.month - i);
      }
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

    refreshProducts(int value) async {
      products.clear();
      await productService.getProducts(value);
      setState(() {
        products = productService.aux;

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
            Visibility(
              visible: isSelected,
              child: Container(
                  child: SfCartesianChart(
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        // Bind data source
                        dataSource: <SalesData>[
                          SalesData(35, months[0]),
                          SalesData(28, months[1]),
                          SalesData(34, months[2]),
                          SalesData(32, months[3]),
                          SalesData(40, months[4]),
                          SalesData(40, months[5]),
                        ],
                        xValueMapper: (SalesData order, _) => '$order.month',
                        yValueMapper: (SalesData order, _) => order.sales)
                  ])),
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
  final double sales;
}
