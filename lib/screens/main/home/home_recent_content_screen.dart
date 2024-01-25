import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class homeRecentContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int itemCount = 10;
    double itemHeight = 150;
    double itemWidth = 150;

    return GridView.builder(
      padding: EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        childAspectRatio: (itemWidth / itemHeight),
        crossAxisSpacing: 8, // Spacing between columns
        mainAxisSpacing: 8, // Spacing between rows
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: Card(
                elevation: 0.0,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 10, right: 10, bottom: 10),
                  child: Text(
                    'المعتزل وأنتاج. قرارة تحليلية وكشفت لمكافحة الفضول التنبؤي',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 4, right: 4),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: AssetImage('assets/images/bk2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('المقالات'),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
