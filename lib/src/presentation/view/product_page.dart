import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackerkernel_task/src/presentation/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.listTitle,
  });
  final String listTitle;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // height: 350,
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: productProvider.productList.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: size.width / 2.2,
                    mainAxisExtent: 250,
                  ),
                  itemCount: productProvider.productList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(right: 12),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 95,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
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
                                    productProvider.deleteProduct(0);
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
                            productProvider.productList[index]['productName'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            productProvider.productList[index]['isAvailable']
                                ? '• Available'
                                : '• Not Available',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: productProvider.productList[index]
                                          ['isAvailable']
                                      ? const Color.fromARGB(255, 84, 224, 126)
                                      : const Color.fromARGB(255, 248, 71, 71),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            productProvider.productList[index]['productPrice'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color:
                                      const Color.fromARGB(255, 136, 136, 136),
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No Product Found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
        ),
      ),
    );
  }
}
