import 'dart:async';

import '../models/NewsCatModel.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

//Create an event for bloc
enum NewsFetch { fetch }
//create news bloc class

class NewsBloc {
  // List<String> newsList = [];

  //create StreamControllers for Sink (Input)and Stream (Output)
  final newsStreamController = StreamController<List<NewsModel>>();

  StreamSink<List<NewsModel>> get _newsSink => newsStreamController.sink;
  Stream<List<NewsModel>> get newsStream =>
      newsStreamController.stream; // to be called in Home UI

  final eventStreamColtroller = StreamController<NewsFetch>();

  StreamSink<NewsFetch> get eventSink => eventStreamColtroller.sink;
  Stream<NewsFetch> get _eventStream => eventStreamColtroller
      .stream; //Used in Input Of Event to Bloc and Then is listened

  var newsModel;
//Listen to the event stream
  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsFetch.fetch) {
        try {
          if (newsModel != null)
            _newsSink.add(newsModel.title);
          else
            _newsSink.addError("Can Not Fetch");
        } catch (e) {
          print("Can Not Fetch");
        }
      }
    });
  }
  Future<void> getNews() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=c24f66b674b64398878a20fb172c007b'));

    var jsonData = jsonDecode(response.body);
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
          return newsModel;
        } else {
          print('Hehe');
        }
      });
    }
  }

  void dispose() {
    newsStreamController.close();
    eventStreamColtroller.close();
  }
}
/*
class SearchBloc {
  // List<String> newsList = [];
  final newsStreamController = StreamController<List<NewsModel>>();

  StreamSink<List<NewsModel>> get _newsSink => newsStreamController.sink;
  Stream<List<NewsModel>> get newsStream =>
      newsStreamController.stream; // to be called in Home UI

  final searchStreamColtroller = StreamController<NewsFetch>();

  StreamSink<NewsFetch> get eventSink => searchStreamColtroller.sink;
  Stream<NewsFetch> get _eventStream => searchStreamColtroller
      .stream; //Used in Input Of Event to Bloc and Then is listened

  var newsModel;

  SearchBloc() {
    _eventStream.listen((event) async {
      if (event == NewsFetch.fetch) {
        try {
          if (newsModel != null)
            _newsSink.add(newsModel.title);
          else
            _newsSink.addError("Can Not Fetch");
        } catch (e) {
          print("Can Not Fetch");
        }
      }
    });
  }
  Future<void> getNews() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=c24f66b674b64398878a20fb172c007b'));

    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonData['status'] == "ok") {
      print('Hehe');
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsModel newsModel = NewsModel(
            title: element["title"],

            //publishedAt: element['publishedAt'],
          );
          return newsModel.title.toLowerCase();
        } else {}
      });
    }
  }

  void dispose() {
    newsStreamController.close();
    searchStreamColtroller.close();
  }
}*/
