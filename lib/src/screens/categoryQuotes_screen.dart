import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/dom_parsing.dart' as dom_parser;
import 'package:html/parser.dart' as parser;

class CategoryQuotesScreen extends StatefulWidget {
  final String category;

  const CategoryQuotesScreen({Key key, this.category}) : super(key: key);
  @override
  _CategoryQuotesScreenState createState() => _CategoryQuotesScreenState();
}

class _CategoryQuotesScreenState extends State<CategoryQuotesScreen> {
  List quotelist = [];
  int currentPage = 1;
  bool morePossible = true;
  ScrollController _scrollController = ScrollController();

  getData() async {
    if (morePossible) {
      print("loading more");
      var url =
          "https://quotes.toscrape.com/tag/${widget.category}/page/$currentPage/";
      var response = await http.get(url);
      dom.Document document = parser.parse(response.body);
      List newQuotelist = document.getElementsByClassName("quote");
      print("New Quotelist : $newQuotelist");
      setState(() {
        if (newQuotelist == null || newQuotelist.length == 0) {
          morePossible = false;
        } else {
          quotelist += newQuotelist;
          currentPage += 1;
        }
        print("${quotelist.length}");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: quotelist.length == 0
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: quotelist.length,
                    itemBuilder: (context, index) {
                      var quote = quotelist[index]
                          .getElementsByClassName("text")[0]
                          .innerHtml;
                      var author = quotelist[index]
                          .getElementsByClassName("author")[0]
                          .innerHtml;
                      return Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 10.0,
                        child: ListTile(
                          dense: false,
                          contentPadding: EdgeInsets.all(15.0),
                          tileColor: Colors.brown[100],
                          title: Text(
                            quote,
                          ),
                          subtitle: Text(
                            "-" + author,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.red[400],
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
    ;
  }
}
