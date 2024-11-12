import 'package:fakestore/controller/product_controller.dart';
import 'package:fakestore/model/product_model.dart';
import 'package:fakestore/ui/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AllProductScreen extends StatefulWidget {
  final String category;

  AllProductScreen(this.category);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  final ProductController controller = Get.put(ProductController());

  // Map to store quantities for each product
  Map<int, int> _quantities = {};

  void _increment(int productId) {
    setState(() {
      _quantities[productId] = (_quantities[productId] ?? 0) + 1;
    });
  }

  void _decrement(int productId) {
    setState(() {
      // Allow the quantity to go down to 0
      if ((_quantities[productId] ?? 0) > 0) {
        _quantities[productId] = (_quantities[productId] ?? 0) - 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // Log or print to verify category
    print('Category: ${widget.category}');

    // Call the controller method to filter products by category
    controller.filterProductsByCategory(widget.category);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
            child: Container(
              margin: EdgeInsets.only(right: 50),
              child: Text(widget.category,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            )),
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return  Center(child: CircularProgressIndicator());
                      } else if (controller.getFilteredProducts().isEmpty) {
                        return  Center(child: Text("No products available."));
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics:  NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            crossAxisSpacing: 5.0, // Horizontal spacing between items
                            mainAxisSpacing: 0.0, // Vertical spacing between items
                            childAspectRatio: 0.75, // Aspect ratio of each grid item
                          ),
                          itemCount: controller.getFilteredProducts().length,
                          itemBuilder: (context, index) {
                            var product = controller.getFilteredProducts()[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         ProductDetailsScreen(product: product),
                                //   ),
                                // );
                                Navigator.of(context).push(_createRoute(product));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 140, // Adjust image height as needed
                                            child: Image.network(
                                              product.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(height: 4),
                                                // Decrement and quantity counter only show when quantity > 0
                                                if ((_quantities[product.id] ?? 0) > 0)
                                                  GestureDetector(
                                                    onTap: () => _decrement(product.id),
                                                    child: Container(
                                                      width: 25,
                                                      height: 25,
                                                      child:  Icon(Icons.remove, color: Colors.white),
                                                    ),
                                                  ),
                                                if ((_quantities[product.id] ?? 0) > 0)
                                                  Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${_quantities[product.id] ?? 0}',
                                                        textAlign: TextAlign.center,
                                                        style:  TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                // Increment button is always visible
                                                GestureDetector(
                                                  onTap: () => _increment(product.id),
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    child:  Icon(Icons.add, color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$${product.price}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "\$${product.price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom route with sliding transition
  PageRouteBuilder _createRoute(ProductModel product) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ProductDetailsScreen(product: product),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Sliding transition (from right to left)
        const begin = Offset(1.0, 0.0); // Start from the right
        const end = Offset.zero; // End at the current position
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Slide the page horizontally and fade in
        return SlideTransition(position: offsetAnimation, child: FadeTransition(opacity: animation, child: child));
      },
    );
  }
}