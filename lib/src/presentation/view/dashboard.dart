import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackerkernel_task/src/presentation/provider/product_provider.dart';
import 'package:hackerkernel_task/src/presentation/view/add_product/add_product.dart';
import 'package:hackerkernel_task/src/presentation/view/login_page.dart';
import 'package:hackerkernel_task/src/presentation/view/product_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String searchValue = '';
  bool isEnable = false;

  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.initProductProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 241, 243),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => const AddProduct(),
            ),
          );
        },
        backgroundColor: const Color(0xFF1E6EE7),
        shape: const CircleBorder(),
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFF9B99A2),
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.angleLeft,
                      color: Color(0xFF9B99A2),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFF9B99A2),
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                        color: Color(0xFF9B99A2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      if (!mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                      setState(() {});
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFF9B99A2),
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.rightFromBracket,
                        size: 20,
                        color: Color(0xFF9B99A2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                'Hi-Fi Shop & Service',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                'Audio shop on Rustaveli Ave 57.\nThis shop offers both products and services',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF9B99A2),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 48),
              const ItemListView(
                listTitle: 'Products',
              ),
              const ItemListView(
                listTitle: 'Accessories',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemListView extends StatefulWidget {
  const ItemListView({super.key, required this.listTitle});

  final String listTitle;

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    Iterable<Map<String, dynamic>> itemCount =
        productProvider.productList.where(
      (element) => element['productType'] == widget.listTitle,
    );
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.listTitle,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              " ${itemCount.length.toString()}",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: const Color(0xFF9B99A2),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => ProductPage(
                      listTitle: widget.listTitle,
                    ),
                  ),
                );
              },
              child: Text(
                'Show all',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color(0xFF1E6EE7),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 250,
          width: size.width,
          child: itemCount.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: productProvider.productList.length,
                  itemBuilder: (context, index) {
                    return productProvider.productList[index]['productType'] ==
                            widget.listTitle
                        ? SizedBox(
                            width: 190,
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(right: 12),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        height: 114,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: Center(
                                          child: Image.network(
                                            productProvider.productList[index]
                                                ['imageLink'],
                                            errorBuilder: (context, obj, strc) {
                                              return Center(
                                                child: Text(
                                                  "Image not found",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // child: List
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: IconButton(
                                          onPressed: () {
                                            productProvider
                                                .deleteProduct(index);
                                            setState(() {});
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.trashCan,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    productProvider.productList[index]
                                        ['productName'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    productProvider.productList[index]
                                            ['isAvailable']
                                        ? '• Available'
                                        : '• Not Available',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color:
                                              productProvider.productList[index]
                                                      ['isAvailable']
                                                  ? const Color.fromARGB(
                                                      255, 84, 224, 126)
                                                  : const Color.fromARGB(
                                                      255, 248, 71, 71),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    productProvider.productList[index]
                                        ['productPrice'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: const Color.fromARGB(
                                              255, 136, 136, 136),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : Center(
                  child: Text(
                    'No Product Available',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  String listTitle = '';
  List<String> searchTerms = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.productList.length != searchTerms.length) {
      for (var product in productProvider.productList) {
        searchTerms.add(product['productName']);
      }
    }

    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var product in searchTerms) {
      if (product.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var product in searchTerms) {
      if (product.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductPage(listTitle: 'Product'),
              ),
            );
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
