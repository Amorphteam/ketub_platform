import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ketub_platform/widget/style_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EpubScreen extends StatefulWidget {
  const EpubScreen({Key? key}) : super(key: key);

  @override
  _EpubScreenState createState() => _EpubScreenState();
}

class _EpubScreenState extends State<EpubScreen> {
  late PageController _pageController;
  bool _webViewIsScrolling = true;
  bool enableAgreeButton = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String htmlText = '''
      <html>
        <head>
        <script>
window.onscroll = function(ev) {
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
    window.FLUTTER_CHANNEL.postMessage('end of scroll');
    }
};
</script>
          <style>
          body {
          padding: 40px;
          direction: rtl;
          }
            h1 {
              font-size: 80px;
            }
            p {
              color: grey;
              font-size: 40px;
            }
          </style>
        </head>
        <body>
          <h1>این یک عنوان هست</h1>
<p>هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.<br />إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.<br />ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.<br />هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.</p>
<p>هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.<br />إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.<br />ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.<br />هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.</p>
<p>هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.<br />إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.<br />ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.<br />هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.</p>
<p>هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.<br />إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.<br />ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.<br />هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.</p>
<p>هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.<br />إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.<br />ومن هنا وجب على المصمم أن يضع نصوصا مؤقتة على التصميم ليظهر للعميل الشكل كاملاً،دور مولد النص العربى أن يوفر على المصمم عناء البحث عن نص بديل لا علاقة له بالموضوع الذى يتحدث عنه التصميم فيظهر بشكل لا يليق.<br />هذا النص يمكن أن يتم تركيبه على أي تصميم دون مشكلة فلن يبدو وكأنه نص منسوخ، غير منظم، غير منسق، أو حتى غير مفهوم. لأنه مازال نصاً بديلاً ومؤقتاً.</p>
        </body>
      </html>
    ''';


    return Scaffold(
      appBar: AppBar(
        title: Text('Epub Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button search was pressed!'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {
              _showBottomSheet(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button bookmark was pressed!'),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.description_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button toc was pressed!'),
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical, // Set vertical scroll direction
                    itemCount: 20, // Number of pages (WebView instances)
                    physics: _webViewIsScrolling
                        ? NeverScrollableScrollPhysics() // Prevent PageView scrolling
                        : AlwaysScrollableScrollPhysics(), // Allow PageView scrolling
                    itemBuilder: (context, index) {
                      return buildWebView(htmlText); // Pass your HTML content here
                    },
                    onPageChanged: (index){
                      // Reset the WebView scrolling flag when changing pages
                      setState(() {
                        _webViewIsScrolling = true;
                      });
                    },
                  ),
                ),
                Container(padding: EdgeInsets.all(20), child: Text('12/344'))
              ],
            ),
          ),
          VerticalSeekBar(),
        ],
      ),
    );
  }

  Widget buildWebView(String htmlContent) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        // Load HTML content when the WebView is created
        webViewController.loadUrl(Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString());
      },
      javascriptChannels: [
        JavascriptChannel(
            name: 'FLUTTER_CHANNEL',
            onMessageReceived: (message) {
              if (message.message.toString() ==
                  "end of scroll") {
                setState((){
                  _webViewIsScrolling = false;
                });
              }
            })
      ].toSet(),
      gestureNavigationEnabled: true,
      debuggingEnabled: true,
      onPageStarted: (url) {
        // WebView scrolling started, prevent PageView scrolling
        // setState(() {
        //   _webViewIsScrolling = true;
        // });
        print('started');

      },
      onPageFinished: (url) {
        // WebView scrolling finished, allow PageView scrolling
        // setState(() {
        //   _webViewIsScrolling = false;
        // });
        print('finished');
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StyleSheet();
      },
    );
  }
}


class VerticalSeekBar extends StatefulWidget {
  const VerticalSeekBar({Key? key});

  @override
  _VerticalSeekBarState createState() => _VerticalSeekBarState();
}
class _VerticalSeekBarState extends State<VerticalSeekBar> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1, // Rotate the SeekBar 90 degrees (bottom-up orientation)
      child: Slider(
        value: _sliderValue,
        onChanged: (newValue) {
          setState(() {
            _sliderValue = newValue;
          });
        },
      ),
    );
  }
}


