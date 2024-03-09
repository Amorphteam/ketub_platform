import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoInternetScreen extends StatefulWidget {
  final Function retry;

  const NoInternetScreen({super.key, required this.retry});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To center the content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(24),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/images/bk.svg',
                        fit: BoxFit.fill, // This will cover the entire background of the Container
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                      child: Column(
                        children: [
                          SizedBox(height: 80),

                          // Your other widgets go here
                          SvgPicture.asset(
                            'assets/icons/no_internet.svg',
                          ),
                          SizedBox(height: 20),
                          Text(
                            'أنت غير متصل',
                          style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'يرجى التحقق من الاتصال بالانترنت وحاول مرة أخرى.',
                            style: Theme.of(context).textTheme.labelLarge,

                          ),
                          SizedBox(height: 80),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  widget.retry(); // assuming you want to retry the operation when this button is pressed
                },
                child: Text('إعادة المحاولة'),
              ),
              TextButton(
                onPressed: () {

                },
                child: Text('انتقل إلى قسم الكتب والمؤلفات'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
