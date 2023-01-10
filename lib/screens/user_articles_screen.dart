import 'dart:ffi';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:trabajo_flutter/providers/precio_form_provider.dart';

import '../models/models.dart';
import '../services/services.dart';

import 'package:provider/provider.dart';

class UserArticleScreen extends StatefulWidget {
  const UserArticleScreen({Key? key}) : super(key: key);

  @override
  _UserArticleScreenState createState() => _UserArticleScreenState();
}

class _UserArticleScreenState extends State<UserArticleScreen> {
  List<DataArticles> articles = [];
  int counter = 0;
  List<DataProductsCompany> products = [];
  List<DataFamilies> families = [];

  final articlesServices = ArticlesServices();

  final familiesServices = FamiliesServices();

  Future refresh() async {
    setState(() => articles.clear());

    final productsCompanyService =
        Provider.of<ProductsCompanyServices>(context, listen: false);

    await productsCompanyService.postProductsCompany();

    products = productsCompanyService.productsCompany;

    await articlesServices.loadArticles();
    await familiesServices.loadFamilies();

    setState(() {
      counter = 0;
      families = familiesServices.families;
      articles = articlesServices.articles;
      for (var p in products) {
        articles.removeWhere((element) => element.id == p.articleId);
      }
    });
  }

  void updateList(String value) {
    setState(() {
      articles = articlesServices.articles
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    final productAdd = Provider.of<ProductAddServices>(context);
    final precioForm = Provider.of<PrecioFormProvider>(context);
    final productsCompanyService =
        Provider.of<ProductsCompanyServices>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
              child: Container(
            margin: EdgeInsets.all(10),
            child: Text('articles added: $counter',
                style: TextStyle(fontSize: 16)),
          ))
        ],
        leading: IconButton(
          icon: Icon(Icons.add_shopping_cart_outlined),
          onPressed: () => Navigator.pushNamed(context, 'userCompany'),
        ),
        backgroundColor: Color.fromARGB(255, 17, 158, 125),
        elevation: 0.0,
      ),
      backgroundColor: const Color.fromARGB(255, 222, 222, 222),
      body: articlesServices.isLoading
          ? const Center(
              child:
                  SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50))
          : SingleChildScrollView(
              child: Form(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: 30, top: 10, bottom: 10),
                        height: 50,
                        width: 300,
                        child: TextField(
                          onChanged: ((value) => updateList(value)),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Color.fromARGB(55, 17, 158, 125),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 600,
                      width: 300,
                      child: Container(
                          child: Expanded(
                        flex: 10,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: articles.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 215,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 235, 229, 229),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 3,
                                          color: const Color.fromARGB(
                                              255, 17, 158, 125)),
                                    ),
                                    child: Column(
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
                                                    .add_shopping_cart_outlined),
                                                onPressed: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  if (productsCompanyService
                                                          .productsCompany
                                                          .length >
                                                      5) {
                                                    CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.error,
                                                      title:
                                                          'Limit of articles: 5',

                                                      borderRadius: 30,
                                                      //loopAnimation: true,
                                                      confirmBtnColor:
                                                          Colors.red,
                                                    );
                                                  } else {
                                                    if (precioForm.precio ==
                                                            '' ||
                                                        double.parse(precioForm.precio) <
                                                            double.parse(
                                                                articles[index]
                                                                    .priceMin) ||
                                                        double.parse(precioForm
                                                                    .precio) +
                                                                (double.parse(
                                                                        precioForm
                                                                            .precio) *
                                                                    (double.parse(families.elementAt(articles[index].familyId).profitMargin) /
                                                                        100)) >
                                                            double.parse(
                                                                articles[index]
                                                                    .priceMax)) {
                                                      return CoolAlert.show(
                                                        context: context,
                                                        type:
                                                            CoolAlertType.error,
                                                        title:
                                                            'Enter a correct price',
                                                        text:
                                                            'Min price: ${articles[index].priceMin}, Min price: ${articles[index].priceMax}',
                                                        borderRadius: 30,
                                                        //loopAnimation: true,
                                                        confirmBtnColor:
                                                            Colors.red,
                                                      );
                                                    }
                                                    await productAdd
                                                        .postProductAdd(
                                                            articles[index].id,
                                                            double.parse(
                                                                precioForm
                                                                    .precio),
                                                            articles[index]
                                                                .familyId);

                                                    setState(() {
                                                      counter++;
                                                      articles.removeAt(index);
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            Text(articles[index].name,
                                                style: const TextStyle(
                                                    fontSize: 25))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                    articles[index].description,
                                                    style: const TextStyle(
                                                        fontSize: 20))),
                                            //Text(articles[index].price,style: TextStyle(fontSize: 40))),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: const Text('Price: ',
                                                    style: TextStyle(
                                                        fontSize: 30))),

                                            Container(
                                              width: 170,
                                              height: 40,
                                              margin: EdgeInsets.only(top: 30),
                                              child: TextFormField(
                                                autocorrect: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                maxLength: 10,
                                                maxLengthEnforcement:
                                                    MaxLengthEnforcement
                                                        .enforced,
                                                decoration:
                                                    const InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 18, 201, 159)),
                                                  ),
                                                ),
                                                onChanged: (value) =>
                                                    precioForm.precio = value,
                                              ),
                                            ) //Text(articles[index].price,style: TextStyle(fontSize: 40))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      )))
                ]),
              ),
            ),
    );
  }
}
