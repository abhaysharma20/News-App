//import 'package:flutter/rendering.dart';
import 'dart:io';

//import 'package:connectivity/connectivity.dart';
//import 'dart:js';

import 'package:newsapp/models/NewsCatModel.dart';
import 'dart:convert';

//import 'dart:io';
//import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

////import 'package:newsapp/screens/internetConnection.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = <CategoryModel>[];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "Business";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1551836022-aadb801c60ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80";
  category.add(categoryModel);

  //2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80";
  category.add(categoryModel);

  //3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80";
  category.add(categoryModel);

  //4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1516339901601-2e1b62dc0c45?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1840&q=80";
  category.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1568290747765-1b4a44724fe9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1960&q=80";
  category.add(categoryModel);

  //6
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  category.add(categoryModel);

  return category;
}
//
//

class News {
  List<NewsModel> news = [];
//$CategoryModel[index]
  Future<void> getNews() async {
    String _url =
        "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=c24f66b674b64398878a20fb172c007b";

    var response = await http.get(Uri.parse(_url));
    var jsonData = jsonDecode(response.body);

    /*try {
      if (response.statusCode == 200) {
        print('Internet Connected');
      }
    } catch (e) {
      print('Request failed with status: ${response.statusCode}.');
    }*/

    if (response.statusCode == 200 && jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel newsModel = NewsModel(
            title: element["title"],
            author: element["author"],
            description: element['description'],
            url: element['url'], //url of the news
            content: element['content'],
            urlToImage: element['urlToImage'], //Url of the image
            //publishedAt: element['publishedAt'],
          );
          news.add(newsModel);
          //return news;

        } else {}
      });
    }
  } //catch (e) {
  //print('Request failed with status: ${response.statusCode}.');
}

class CategoryWiseNews {
  List<NewsModel> news = [];

  Future<void> getNewsForCategory(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=c24f66b674b64398878a20fb172c007b";

    try {
      final result = await InternetAddress.lookup('www.google.com');
      //ignore: unused_local_variable
      //var response = await http.get(Uri.parse(_url));

      if (result.isNotEmpty || result[0].rawAddress.isNotEmpty) {
        print('You Are Connected');

        var response = await http.get(Uri.parse(url));

        var jsonData = jsonDecode(response.body);

        if (jsonData['status'] == "ok") {
          jsonData["articles"].forEach((element) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              NewsModel article = NewsModel(
                title: element['title'],
                author: element['author'],
                description: element['description'],
                urlToImage: element['urlToImage'],
                //publshedAt: DateTime.parse(element['publishedAt']),
                content: element["content"],
                url: element["url"],
              );
              news.add(article);
              // ignore: unused_local_variable
              String searchTitle;
              return searchTitle = article.title.toLowerCase();
            }
          });
        }
      }
    } on SocketException catch (_) {
      print('Not connected');
    }
  }
}


/*class InternetCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (BuildContext ctxt,
                AsyncSnapshot<ConnectivityResult> snapShot) {
              if (!snapShot.hasData) return CircularProgressIndicator();
              var result = snapShot.data;
              switch (result) {
                case ConnectivityResult.none:
                  print("no net");
                  return Center(child: Text("No Internet Connection!"));
                case ConnectivityResult.mobile:
                case ConnectivityResult.wifi:
                  print("yes net");
                  return Center(
                    child: Text('Welcome to home Page'),
                  );
                default:
                  return Center(child: Text("No Internet Connection!"));
              }
            })
      );
  }
}*/