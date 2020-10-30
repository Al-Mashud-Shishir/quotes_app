import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/src/widgets/gridCategory_widget.dart';

class HomeScreen extends StatelessWidget {
  List<String> _categoryList = ["love", "inspiration", "life", "humor"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(
          "Quotes",
          style: GoogleFonts.lobster(
            textStyle: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w200,
              letterSpacing: 3,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: _categoryList
                    .map(
                      (e) => GridCategoryWidget(
                        category: e,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
