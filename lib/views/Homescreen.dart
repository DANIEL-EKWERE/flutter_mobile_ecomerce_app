import 'package:ecommerce1/controller/api_service.dart';
import 'package:ecommerce1/models/products_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final productsCategoryController =
        Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            print('will work on this soon');
          },
        ),
        actions: [
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assest/images/system-uicons_cart.svg"),
          ),
          const SizedBox(
            width: 20,
          ),
          const CircleAvatar(
            radius: 23,
            backgroundColor: Color(0xff0183AC),
            backgroundImage: AssetImage(
              "assest/images/cover .png",
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff0183AC),
                Color(0xff7BDFFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 20, vertical: 13),
                      suffixIcon: const IconTheme(
                        data: IconThemeData(color: Color(0xff0183AC)),
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                          color: Color(0xffa4aaad), 
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 30.0,
                          color: Color(0xff0183AC),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 48,
                  width: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xff0183AC),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: SvgPicture.asset(
                      'assest/images/carbon_settings-adjust.svg'),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Categories',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<ProductsCategory>>(
                future: productsCategoryController.getProducts(),
                builder: (context, snashot) {
                  if (snashot.hasData) {
                    final products = snashot.data;
                    return Expanded(
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: products!.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 3 / 3.5,
                            mainAxisSpacing: 15,
                            // crossAxisSpacing: 18,
                          ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    // color: Color(0xffFEB700),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(product.image),
                                    ),
                                  ),
                                ),
                                Text(categoryValues.reverse[product.category]!)
                              ],
                            );
                          }),
                    );
                  } else if (snashot.hasError) {
                    return Text('Error ${snashot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
