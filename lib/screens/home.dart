//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/NewsCatModel.dart';
import 'package:newsapp/resources/fetchCategory.dart';
import 'package:newsapp/screens/listView.dart';
//import 'package:toast/toast.dart';

//import 'package:newsapp/screens/newsWebview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    //Called when out application is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News API App"),
      ),

      //
      //

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Hero(
                    tag: 'news',
                    child: Image.asset(
                      'assets/NEWSFRONT.jfif',
                      height: 130,
                    ),
                  )
                ],
              ),
            ),
            //
            //
            Text(
              'Select The Category for News',
              textAlign: TextAlign.center,
            ),
            Divider(
              thickness: 1,
              height: 10,
              indent: 20,
              endIndent: 0,
              color: Colors.white30,
            ),
            Container(
                height: 350,
                child: ListView.builder(
                  itemCount: categories.length,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return CategoryListView(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                )),
            Divider(
              thickness: 1,
              height: 5,
              indent: 20,
              endIndent: 0,
              color: Colors.white30,
            ),
          ],
        ),
      ),

      //
      //
      //

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News API App",
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 50,
                )),
            Divider(),
            Divider(),
            Hero(
              tag: 'news',
              child: Image.asset(
                'assets/NEWSFRONT.jfif',
                alignment: Alignment.topCenter,
              ),
            ),
            Divider(),
            Divider(),
            Text("Select News Category",
                style: TextStyle(
                  fontSize: 30,
                )),
            Text("From Drawer",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 30,
                )),
          ],
        ),
      ),
    );
  }
}

/*
class NewsBox extends StatelessWidget {
  final String imageUrl, posturl, title, desc;
  NewsBox(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.posturl});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: 200,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsWebView(
                            onTapUrl: posturl,
                          )));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.horizontal(),
                child: Image.network(imageUrl)),
          ),
          Divider(
            thickness: 1,
            height: 10,
            indent: 20,
            endIndent: 0,
            color: Colors.white30,
          ),
          Card(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                Divider(
                  thickness: 1,
                  height: 10,
                  indent: 20,
                  endIndent: 0,
                  color: Colors.white30,
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
