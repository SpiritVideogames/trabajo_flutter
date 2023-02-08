import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/company_form_provider.dart';
import '../services/productsCompany_services2.dart';
import '../services/services.dart';

class GraphsScreen extends StatefulWidget {
  const GraphsScreen({super.key});

  @override
  State<GraphsScreen> createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  List<DataProductsCompany> products = [];
  final productService = ProductsCompanyServices2();
  int? idTargetCompany;
  Future refresh() async {
    setState(() => products.clear());
    await productService.postProductsCompany();
    idTargetCompany = await UserServices().readIdCompany();
    setState(() {
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
    final companyForm = Provider.of<CompanyFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Graphs'),
      ),
      body: SizedBox(
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
              return (value != null && value != 0) ? null : 'Select a Product';
            },
          ),
        ],
      )),
    );
  }
}
