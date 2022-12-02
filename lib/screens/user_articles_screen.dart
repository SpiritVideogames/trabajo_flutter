import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: const Color.fromARGB(255, 222, 222, 222),
        body: articlesServices.isLoading
            ? const Center(
                child: SpinKitWave(
                    color: Color.fromRGBO(0, 153, 153, 1), size: 50))
            : RefreshIndicator(
                onRefresh: refresh,
                child: SingleChildScrollView(
                  child: Form(
                    key: precioForm.formKey,
                    child: Column(children: [
                      Row(
                        children: [
                          Stack(children: [
                            Container(
                              color: const Color.fromARGB(255, 25, 205, 163),
                              height: 90,
                              width: 360,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  const BoxShadow(
                                    spreadRadius: 2,
                                    color: Colors.white,
                                    blurRadius: 5,
                                    offset: Offset(0, 0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 3,
                                    color: const Color.fromARGB(
                                        255, 17, 158, 125)),
                              ),
                              child: IconButton(
                                color: const Color.fromARGB(255, 17, 147, 116),
                                iconSize: 50,
                                icon: const Icon(
                                    Icons.collections_bookmark_rounded),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'userCompany');
                                },
                              ),
                            ),
                          ]),
                          const SizedBox(height: 150),
                        ],
                      ),
                      SizedBox(
                          height: 600,
                          width: 300,
                          child: Container(
                              child: Swiper(
                            scrollDirection: Axis.vertical,
                            itemCount: articles.length,
                            layout: SwiperLayout.STACK,
                            itemWidth: 600,
                            itemHeight: 200,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                height: 200,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 235, 229, 229),
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
                                            onPressed: () {
                                              FocusScope.of(context)
                                                  .requestFocus(FocusNode());
                                              print(productAdd.postProductAdd(
                                                  articles[index].id,
                                                  precioForm.precio,
                                                  articles[index].familyId));
                                              setState(() {
                                                articles.removeAt(index);
                                              });
                                            },
                                          ),
                                        ),
                                        Text(articles[index].name,
                                            style:
                                                const TextStyle(fontSize: 25))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.all(10),
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
                                            margin: const EdgeInsets.all(10),
                                            child: Text('Precio: ',
                                                style: const TextStyle(
                                                    fontSize: 30))),
                                        Container(
                                          width: 60,
                                          height: 30,
                                          child: TextFormField(
                                              autocorrect: false,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            18,
                                                            201,
                                                            159))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 18, 201, 159)),
                                                ),
                                              ),
                                              onChanged: (value) =>
                                                  precioForm.precio =
                                                      double.parse(value)),
                                        ),

                                        //Text(articles[index].price,style: TextStyle(fontSize: 40))),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )))
                    ]),
                  ),
                ),
              ));
  }
}
