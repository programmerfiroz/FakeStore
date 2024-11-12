import 'package:fakestore/controller/product_controller.dart';
import 'package:fakestore/ui/product_details_screen.dart';
import 'package:fakestore/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'categories.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.put(ProductController());

  final List<String> imageUrls = [
    "https://img.freepik.com/free-vector/grocery-store-sale-banner-template_23-2151089846.jpg",
    "https://img.freepik.com/free-vector/grocery-store-facebook-template_23-2151089773.jpg",
    "https://img.freepik.com/free-vector/hand-drawn-supermarket-sale-background_23-2149406388.jpg",
    "https://www.shutterstock.com/image-vector/supermarket-template-groceries-grocery-store-260nw-2362872809.jpg",
  ];
  final List<Map<String, String>> popularDeals = [
    {
      "image":
          "https://media.istockphoto.com/id/1450329221/photo/at-the-fruit-and-vegetable-store.jpg?s=612x612&w=0&k=20&c=Yxfu6C52aU_WSTRWAsTDe42SfliidhX6LwLLp-KWYOM=",
      "title": "Deal 1"
    },
    {
      "image":
          "https://media.gettyimages.com/id/183851510/photo/vegetable-market.jpg?s=612x612&w=gi&k=20&c=XOvuUOhV6CsOvvc5xdlkA6zaeXum5vCup63wEGliLQI=",
      "title": "Deal 2"
    },
    {
      "image":
          "https://freerangestock.com/sample/122344/abundance-of-fresh-fruits-and-vegetables-in-grocery-store.jpg",
      "title": "Deal 3"
    },
    {
      "image":
          "https://www.clarifruit.com/wp-content/uploads/elementor/thumbs/Retailer-blog-post-image-q33z5wnge3mua1g2njdihq3cs1vvo4tcmdn3epu0rg.jpg",
      "title": "Deal 4"
    },
    {
      "image":
          "https://img.freepik.com/premium-photo/grocery-store-with-fruits-vegetables-background_882954-8528.jpg",
      "title": "Deal 5"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            _buildHeader(context),
            _buildSearchBar(),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey 😊",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Let's search your grocery food",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.5),
              color: Colors.lightGreen[100],
            ),
            clipBehavior: Clip.hardEdge,
            // Ensures that the image respects the rounded corners
            child: CachedNetworkImage(
              imageUrl:
                  "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
              height: 45,
              width: 45,
              fit: BoxFit.cover,
              // Ensures the image covers the container's area
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search your daily grocery food',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Categories()));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 110,
              child: Obx(() {
                if (productController.categoryList.isEmpty) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Show loading indicator if categories are still being fetched
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productController.categoryList.length,
                  itemBuilder: (context, index) {
                    return CustomImageTextWidget(
                        context,
                        "assets/images/corn.png",
                        productController.categoryList[
                            index]); // Use category from categoryList
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizotalCardScroll() {
    return Container(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            elevation: 5.0,
            child: Container(
              width: 250, // Fixed width for the card
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                // Optional: to round corners
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity, // Fill width of the card
                  height: double.infinity, // Fill height of the card
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildCategories(),
            SizedBox(height: 20),
            _buildHorizotalCardScroll(),
            SizedBox(height: 20),
            _buildPopularDeals(),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Porducts",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productController.productList.length,
                  itemBuilder: (context, index) {
                    var product = productController.productList[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(product.title),
                      subtitle: Text(
                        "₹${product.price}",
                        style: TextStyle(color: Colors.green),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularDeals() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular deals",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Categories()));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularDeals.length,
                // Use the length of popularDeals
                itemBuilder: (context, index) {
                  // Fetch the image and title from the list
                  String image = popularDeals[index]["image"]!;
                  String title = popularDeals[index]["title"]!;
                  return popularDealsWidget(context, image, title);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


