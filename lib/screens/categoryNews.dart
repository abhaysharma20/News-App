import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/resources/fetchCategory.dart';
import 'package:newsapp/screens/bloc.dart';
import '../models/NewsCatModel.dart';
import '../resources/fetchCategory.dart';
import '../screens/bloc.dart';

//import 'home.dart';
import 'newsWebview.dart';

//Create Class to Access Categories Defined
// ignore: must_be_immutable
class Category extends StatefulWidget {
  final String category;
  //Create Bloc Variable

  Category({this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

TextEditingController _controller = TextEditingController();
List<String> pageCategory = [
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'Tech',
];

class _CategoryState extends State<Category> {
  // ignore: deprecated_member_use
  List<NewsModel> newsArticles = new List();
  bool _loading = true;
  String text = NewsModel().title;
  NewsBloc bloc = NewsBloc();
  //SearchBloc bloc2 = SearchBloc();
  var status = "Not Connected";
  @override
  void initState() {
    super.initState();
    getNewsForCategory();
  }

  getNewsForCategory() async {
    CategoryWiseNews newsClass = CategoryWiseNews();
    await newsClass.getNewsForCategory(widget.category);
    newsArticles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$Category News',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  //
                  //
                  //Create Search Bar

                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      hintText: "Search News with Title",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),

                  //
                ),
              ),
              //
              //
              // Search Implementation On Icon Stream Builder
            ],
          ),
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.share,
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      //
      //
      body: _loading
          ? Center(
              child: Container(
                child: SizedBox(
                    height: 10, width: 300, child: LinearProgressIndicator()),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: StreamBuilder(
                          initialData: bloc.newsStreamController,
                          stream: bloc.newsStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.separated(
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                itemCount: newsArticles.length,
                                itemBuilder: (context, index) {
                                  return NewsBox(
                                    imageUrl: newsArticles[index].urlToImage,
                                    title: newsArticles[index].title,
                                    desc: newsArticles[index].description,
                                    posturl: newsArticles[index].url,
                                  );
                                },
                              );
                            }
                            return Container(); // if ends
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget Status(BuildContext context, String check) {
  return Text(check);
}

//To Show News For Different Categories
class NewsBox extends StatelessWidget {
  final String imageUrl, posturl, title, desc;
  //final String publishedAt;
  NewsBox({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.posturl,
    //@required this.publishedAt
  });
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
}
