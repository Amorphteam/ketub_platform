import 'package:flutter/material.dart';
import 'dart:async';

class ImageSliderWidget extends StatefulWidget {
  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _currentPage = 0;
  final PageController _controller = PageController();
  final List<String> _imageUrls = [
    'assets/images/bk1.jpg',
    'assets/images/bk2.jpg',
    'assets/images/bk3.jpg',
  ];

  final List<String> _titles = [
    ' الاجتهاد المقاصدي و المناطي',
    ' الاجتهاد المقاصدي و المناطي',
    ' الاجتهاد المقاصدي و المناطي',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_controller.hasClients) {
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_imageUrls[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _titles[index],
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button tap
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey.withOpacity(0.5), // Set the background color with opacity
                          onPrimary: Colors.white, // This is the text color
                          elevation: 0,
                        ),
                        child: Text('اقرأ الآن'),
                      ),
                    )


                  ],
                ),
              );
            },
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: SizedBox(
            height: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _imageUrls.length,
                    (index) => AnimatedContainer(
                  width: _currentPage == index ? 20 : 8,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == index ? Theme.of(context).colorScheme.secondary : Colors.grey,
                  ),
                ),
              ),
            )

          ),
        )

      ],
    );
  }
}
