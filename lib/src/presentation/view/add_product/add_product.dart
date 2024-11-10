// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackerkernel_task/src/presentation/provider/product_provider.dart';
import 'package:hackerkernel_task/src/presentation/view/dashboard.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _productNameController = TextEditingController();
  final _productLinkController = TextEditingController();
  final _productPriceController = TextEditingController();

  bool isAvailable = true;
  String dropDownValue = 'Select';

  var items = [
    'Select',
    'Products',
    'Accessories',
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 241, 243),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height - 50,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 48,
                        width: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.angleLeft,
                          color: Color(0xFF9B99A2),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "New Product Details",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AddProductDetails(
                        title: 'Product Name',
                        priffixIcon: FontAwesomeIcons.boxOpen,
                        hintText: 'akg n700ncm2 wireless headphones',
                        controller: _productNameController,
                        color: const Color.fromARGB(255, 107, 73, 60),
                      ),
                      AddProductDetails(
                        title: 'Product Price',
                        priffixIcon: FontAwesomeIcons.moneyBill1,
                        hintText: '\$199.00',
                        controller: _productPriceController,
                        color: const Color.fromARGB(255, 17, 134, 79),
                      ),
                      AddProductDetails(
                        title: 'Image Link',
                        priffixIcon: FontAwesomeIcons.link,
                        hintText:
                            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
                        controller: _productLinkController,
                        color: const Color.fromARGB(255, 152, 181, 253),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.circleCheck,
                              color: Color.fromARGB(255, 13, 104, 41),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Product is available',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                            const Spacer(),
                            Checkbox(
                              value: isAvailable,
                              onChanged: (value) {
                                isAvailable = value ?? false;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.checkToSlot,
                              color: Colors.blue[400],
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Select product type',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                            const Spacer(),
                            DropdownButton(
                              value: dropDownValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      if (productProvider.productList.isNotEmpty) {
                        for (var product in productProvider.productList) {
                          if (product['productName'].toLowerCase() ==
                              _productNameController.text.toLowerCase()) {
                            Fluttertoast.showToast(
                                msg: 'Product Already Exist');
                          } else {
                            addProduct(productProvider);
                          }
                        }
                      } else {
                        addProduct(productProvider);
                      }
                    },
                    child: Container(
                      height: 64,
                      width: size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 73, 184),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Add Product',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addProduct(ProductProvider productProvider) {
    if (_productNameController.text.isNotEmpty &&
        _productPriceController.text.isNotEmpty &&
        dropDownValue != 'Select') {
      Map<String, dynamic> product = {
        'imageLink': _productLinkController.text,
        'isAvailable': isAvailable,
        'productName': _productNameController.text,
        'productPrice': '\$${_productPriceController.text}.00',
        'productType': dropDownValue,
      };

      productProvider.addProduct(product);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (builder) => const Dashboard(),
        ),
        (route) => false,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Empty field? please fill all details',
      );
    }
  }
}

class AddProductDetails extends StatefulWidget {
  const AddProductDetails({
    super.key,
    required this.title,
    required this.priffixIcon,
    required this.hintText,
    required this.controller,
    required this.color,
  });
  final String title;
  final IconData priffixIcon;
  final String hintText;
  final TextEditingController controller;
  final Color color;

  @override
  State<AddProductDetails> createState() => _AddProductDetailsState();
}

class _AddProductDetailsState extends State<AddProductDetails> {
  String? _errorText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 5),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FaIcon(
                widget.priffixIcon,
                color: widget.color,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  keyboardType: widget.title == 'Product Price'
                      ? TextInputType.number
                      : TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Eg. ${widget.hintText}',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 165, 165, 165),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 100, 100, 100),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
