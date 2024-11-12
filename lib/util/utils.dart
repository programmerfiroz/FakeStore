import 'package:fakestore/ui/all_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


Widget CustomImageTextWidget(BuildContext context,String imagePath, String category) {
  return GestureDetector(
    onTap: () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => AllProductScreen(category)),
      // );
      Navigator.of(context).push(_createCategoryRoute(category));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightGreen[100],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Image.asset(
                imagePath,
                height: 65,
                width: 65,
              ),
            ),
          ),
           SizedBox(height: 5),
          Text(
            category,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    ),
  );


}


PageRouteBuilder _createCategoryRoute(String category) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        AllProductScreen(category), // Pass the selected category to AllProductScreen
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

Widget popularDealsWidget(BuildContext context, String imageUrl, String category) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AllProductScreen(category)),
      );
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightGreen[100],
            ),
            clipBehavior: Clip.hardEdge, // Ensures that the image respects the rounded corners
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 85,
              width: 100,
              fit: BoxFit.cover, // Ensures the image covers the container's area
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )
,
          SizedBox(height: 5),
          Text(
            category,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
