/*import 'package:filter_listview_example/data/book_data.dart';
import 'package:newsapp/resources/fetchCategory.dart';
import 'package:newsapp/screens/bloc.dart';
import '../main.dart';
import 'package:newsapp/models/NewsCatModel.dart';
//import 'package:filter_listview_example/widget/search_widget.dart';
import 'package:flutter/material.dart';

class SearchNews extends StatefulWidget {
  @override
  SearchNewsState createState() => SearchNewsState();
}

class SearchNewsState extends State<SearchNews> {
  List<News> news;
  String query = '';

  @override
  void initState() {
    super.initState();

    news = allBooks;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final book = news[index];

                  return buildBook(book);
                },
              ),
            ),
          ],
        ),
      );

  /*Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );*/

  /*Widget buildBook(News book) => ListTile(
        leading: Image.network(
          book.urlImage,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(book.title),
        subtitle: Text(book.author),
      );*/

  void searchNews(String query) {
    final books = allBooks.where((title) {
      final titleLower = newsArticles[index].title.toLowerCase();
      final authorLower = book.author.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.news = books;
    });
  }
}*/
