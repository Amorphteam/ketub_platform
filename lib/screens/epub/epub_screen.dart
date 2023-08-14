import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/epub/widgets/style_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/epub_cubit.dart';
import '../../models/book_model.dart';
import '../../models/reference_model.dart';

class EpubScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final BookModel? bookModel;
  const EpubScreen({Key? key, this.referenceModel, this.bookModel}) : super(key: key);

  @override
  _EpubScreenState createState() => _EpubScreenState();
}

class _EpubScreenState extends State<EpubScreen> {

  late PageController _pageController;
  bool _webViewIsScrolling = true;
  bool enableAgreeButton = false;
  WebViewController? _webViewController;
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


  void changeFontSize(String className) {
    _webViewController?.evaluateJavascript('changeFontSize("$className")');
  }
  void changeLineSpace(String className) {
    _webViewController?.evaluateJavascript('changeLineSpace("$className")');
  }

  void changeFontFamily(String className) {
    _webViewController?.evaluateJavascript('changeFontFamily("$className")');
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

function changeFontSize(className) {
          document.body.className = className;
        }
        window.FLUTTER_CHANNEL.postMessage('loaded');
        
        function changeLineSpace(className) {
          document.body.className = className;
        }
        window.FLUTTER_CHANNEL.postMessage('loaded');
        
                function changeFontFamily(className) {
          document.body.className = className;
        }
        window.FLUTTER_CHANNEL.postMessage('loaded');
</script>
          <style>
          .font1 {
          font-family: serif !important; 
          }
                    .font2 {
          font-family: monospace !important; 
          }
          
                    .font3 {
          font-family: cursive !important; 
          }
          
                    .font4 {
          font-family: sans-serif !important; 
          }
          
          
          .normalLineSpace {
          line-height: 100% !important; 
          }
          
                    .smallLineSpace {
          line-height: 80% !important; 
          }
          
                    .largeLineSpace {
          line-height: 140% !important; 
          }
          
                    .xlargeLineSpace {
          line-height: 180% !important; 
          }
          
                    .xxlargeLineSpace {
          line-height: 220% !important; 
          }
          
          .normalFontSize {
          font-size: 40px !important;
          }
          
          .smallFontSize {
          font-size: 30px !important;
          }
          
          .LargeFontSize {
          font-size: 50px !important;
          }
          
          .xlargeFontSize {
          font-size: 60px !important;
          }
          
          .xxlargeFontSize {
          font-size: 70px !important;
          }

          body {
          padding: 40px;
          font-size: 40px;
          direction: rtl;
          }
            h1 {
              font-size: 80px;
            }
            p {
              color: grey;
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
              final epubCubit = BlocProvider.of<EpubCubit>(context);
              _showBottomSheet(context, epubCubit);
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
    return BlocConsumer<EpubCubit, EpubState>(
  listener: (context, state) {
    if (state is FontSizeState) {
      changeFontSize(state.fontSize.name);
    }else if (state is LineSpaceState){
      changeLineSpace(state.lineSpace.name);
    }else if (state is FontFamilyState){
      changeFontFamily(state.fontFamily.name);
    }
  },
  builder: (context, state) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _webViewController = webViewController;
        webViewController.loadUrl(Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString());
      },
      javascriptChannels: {
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
      },
      gestureNavigationEnabled: true,
      debuggingEnabled: true,
    );
  },
);
  }

  void _showBottomSheet(BuildContext context, EpubCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StyleSheet(epubCubit: cubit);
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


