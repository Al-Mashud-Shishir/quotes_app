import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/src/screens/categoryQuotes_screen.dart';

class GridCategoryWidget extends StatelessWidget {
  final String category;

  const GridCategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return CategoryQuotesScreen(
              category: category,
            );
          },
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Text(
            category,
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
