import 'package:flutter/material.dart';
import 'package:newsapp/screens/categoryNews.dart';
import 'package:toast/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryListView extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryListView({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Category(category: categoryName.toLowerCase())));

        Toast.show("$categoryName Chosen", context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.BOTTOM,
            textColor: Colors.black87,
            backgroundColor: Colors.blueAccent);
      },
      child: Container(
        margin: EdgeInsets.only(right: 4, bottom: 4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 300,
                height: 170,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
