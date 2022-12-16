import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:trabajo_flutter/providers/edit_form_provider.dart';
import 'package:trabajo_flutter/providers/precio_form_provider.dart';
import 'package:trabajo_flutter/providers/user_form_provider.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserArticleScreen extends StatefulWidget {
  const UserArticleScreen({Key? key}) : super(key: key);

  @override
  _UserArticleScreenState createState() => _UserArticleScreenState();
}

class _UserArticleScreenState extends State<UserArticleScreen> {
  List<DataArticles> articles = [];

  List<DataProductsCompany> products = [];

  final articlesServices = ArticlesServices();

  Future refresh() async {
    setState(() => articles.clear());

    final productsCompanyService =
        Provider.of<ProductsCompanyServices>(context, listen: false);

    await productsCompanyService.postProductsCompany();

    products = productsCompanyService.productsCompany;

    await articlesServices.loadArticles();

    setState(() {
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
              element.name!.toLowerCase().contains(value.toLowerCase()))
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add_shopping_cart_outlined),
          onPressed: () => Navigator.of(context).pop(),
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
                                                  if (precioForm.precio == '' ||
                                                      double.parse(precioForm
                                                              .precio) <
                                                          double.parse(
                                                              articles[index]
                                                                  .priceMin) ||
                                                      double.parse(precioForm
                                                              .precio) >
                                                          double.parse(
                                                              articles[index]
                                                                  .priceMax)) {
                                                    return CoolAlert.show(
                                                      context: context,
                                                      type: CoolAlertType.error,
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
                                                    articles.removeAt(index);
                                                  });
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

// class CustomSearchDelegate extends SearchDelegate {
//   final articlesServices = ArticlesServices();
//   List<String> searchTerms = ['coche', 'camion', 'moto'];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var article in searchTerms) {
//       if (article.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(article);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }
