import 'package:flutter/services.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';

String ketubCssJs = '''<script>
window.onscroll = function(ev) {
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
    window.FLUTTER_CHANNEL.postMessage('end of scroll');
    }
};

    function changeFontSize(className) {
        document.body.classList.remove('smallFontSize');
        document.body.classList.remove('normalFontSize');
        document.body.classList.remove('largeFontSize');
        document.body.classList.remove('xlargeFontSize');
        document.body.classList.remove('xxlargeFontSize');

        document.body.classList.add(className);
         }
        
        
        function changeLineSpace(className) {
        document.body.classList.remove('smallLineSpace');
        document.body.classList.remove('normalLineSpace');
        document.body.classList.remove('largeLineSpace');
        document.body.classList.remove('xlargeLineSpace');
        document.body.classList.remove('xxlargeLineSpace');

        document.body.classList.add(className);
        
        }
        
         function changeFontFamily(className) {
        document.body.classList.remove('font1');
        document.body.classList.remove('font2');
        document.body.classList.remove('font3');
        document.body.classList.remove('font4');

        document.body.classList.add(className);
         }
         
         // Check if WebView has no scroll
function checkIfNoScroll() {
    var webView = document.documentElement;
    if (webView.scrollHeight <= webView.offsetHeight) {
    window.FLUTTER_CHANNEL.postMessage('has scroll');
        console.log('WebView has no scroll');
    } else {
    window.FLUTTER_CHANNEL.postMessage('no scroll');
        console.log('WebView has scroll');
    }
}
</script>
<style>



html {
    -webkit-text-size-adjust: none; /* Never autoresize text */
    padding: 0 0 !important;
}

body {
  text-indent: 0px !important;
    padding: 40px 40px !important;
    overflow: !important;
        word-break: break-word !important;
    -webkit-hyphens: auto !important;
    hyphens: auto !important;
  direction: rtl;
  text-align: justify;
  text-decoration: none;
  pointer-events: none;
  cursor: default;
}

h1, h2 {
    text-align: center !important;
}

/* Custom padding for tablets */
@media only screen and (min-device-width: 768px){
    body {
        padding: 60px 80px !important;
    }
}


html {
    -webkit-transition: all 0.6s ease;
}



html.BLACK {
    background-color: #131313 !important;
}

.BLACK p, .BLACK div, .BLACK span:not(.epub-media-overlay-playing) {
    color: #767676 !important;
    background-color: transparent !important;
}

.BLACK h1, .BLACK h2, .BLACK h3, .BLACK h4, .BLACK h5, .BLACK h6 {
    color: #848484 !important;
}


html.CONTRAST {
    background-color: #000000 !important;
}

.CONTRAST p:not(.search_highlight),
.CONTRAST div:not(.search_highlight),
.CONTRAST span:not(.search_highlight):not(.epub-media-overlay-playing) {
    color: #FFFFFF !important;
    background-color: transparent !important;
}


.CONTRAST h1, .CONTRAST h2, .CONTRAST h3, .CONTRAST h4, .CONTRAST h5, .CONTRAST h6 {
    color: #FFFFFF !important;
}



html.DARK {
    background-color: #202020 !important;
}

.DARK p:not(.search_highlight),
.DARK div:not(.search_highlight),
.DARK span:not(.search_highlight):not(.epub-media-overlay-playing) {
    color: #767676 !important;
    background-color: transparent !important;
}


.DARK h1, .DARK h2, .DARK h3, .DARK h4, .DARK h5, .DARK h6 {
    color: #848484 !important;
}



html.CREAM {
    background-color: #f9efde !important;

}
.CREAM p, .CREAM div, .CREAM span:not(.epub-media-overlay-playing) {
    background-color: transparent !important;
}

.CREAM h1, .CREAM h2, .CREAM h3, .CREAM h4, .CREAM h5, .CREAM h6 {
}


html.LIGHT {
    background-color: #f9efde !important;

}
.LIGHT p, .LIGHT div, .LIGHT span:not(.epub-media-overlay-playing) {
    background-color: transparent !important;
}

.LIGHT h1, .LIGHT h2, .LIGHT h3, .LIGHT h4, .LIGHT h5, .LIGHT h6 {
}

.FONT0, .FONT0 p, .FONT0 span, .FONT0 div {
    font-family: 'font0', arial;
}

.FONT1, .FONT1 p, .FONT1 h1, .FONT1 h2, .FONT1 h3, .FONT1 h4, .FONT1 h5, .FONT1 h6, .FONT1 span, .FONT1 div {
font-family: font1;
}

.FONT2, .FONT2 p, .FONT2 h1, .FONT2 h2, .FONT2 h3, .FONT2 h4, .FONT2 h5, .FONT2 h6 .FONT2 span, .FONT2 div {
font-family: font2;
}

.FONT3, .FONT3 p, .FONT3 h1, .FONT3 h2, .FONT3 h3, .FONT3 h4, .FONT3 h5, .FONT3 h6, .FONT3 span, .FONT3 div {
font-family: font3;
}

.FONT4, .FONT4 p, .FONT4 h1, .FONT4 h2, .FONT4 h3, .FONT4 h4, .FONT4 h5, .FONT4 h6, .FONT4 span, .FONT4 div {
font-family: font4;
}








html.GREY {
    background-color: #adadad !important;
}
.GREY p, .GREY div, .GREY span:not(.epub-media-overlay-playing) {
    background-color: transparent !important;
}


.search_highlight {
    color: red !important;
}


@font-face {
    font-family: 'normal';
    src: url('font/normal.ttf');
}

@font-face {
    font-family: 'heading1';
    src: url('font/heading1.ttf');
}

@font-face {
    font-family: 'heading2';
    src: url('font/heading2.ttf');
}

@font-face {
    font-family: 'custom1';
    src: url('font/custom1.ttf');
}

@font-face {
    font-family: 'custom2';
    src: url('font/custom2.ttf');
}




html.SIZE0 { font-size: 1em !important; }
html.SIZE1 { font-size: 1.2em !important; }
html.SIZE2 { font-size: 1.5em !important; }
html.SIZE3 { font-size: 1.7em !important; }
html.SIZE4 { font-size: 2.0em !important; }

html.SPACE0 { line-height: 1.4 !important; }
html.SPACE1 { line-height: 1.9 !important; }
html.SPACE2 { line-height: 2.2 !important; }
html.SPACE3 { line-height: 2.5 !important; }
html.SPACE4 { line-height: 2.7 !important; }


.book_name {
  text-align: center;
  font-family: 'heading1', arial;
}
.book_description {
  text-align: center;
}




img{
min-width: 100% !important;
display: block !important;
margin-left: auto !important;
margin-right: auto !important;
 }


          .font1 {
              font-family: font1;
          }
          .font2 {
              font-family: font2;
          }
          
          .font3 {
              font-family: font3;
          }
          
          .font4 {
              font-family: font4;
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
          
          .largeFontSize {
          font-size: 50px !important;
          }
          
          .xlargeFontSize {
          font-size: 60px !important;
          }
          
          .xxlargeFontSize {
          font-size: 70px !important;
          }

</style>''';

String getFontUri(ByteData data, String mime) {
  final buffer = data.buffer;
  return Uri.dataFromBytes(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
          mimeType: mime)
      .toString();
}

Future<String> injectCssJs(String spine) async {
  // Find the index of '</head>' in the HTML
  final headIndex = spine.indexOf('</head>');
  if (headIndex != -1) {
    // Insert the CSS link before '</head>'
    final spineWithCss = spine.replaceRange(headIndex, headIndex, ketubCssJs);
    final spineWithFont = await addFontsToHtml(spineWithCss);
    return spineWithFont;
  }
  return spine;
}

Future<String> addFontsToHtml(String htmlContent) async {
  const fontMime = "font/opentype";
  Map<String, String> fontsAssets = {
    "font1": "assets/fonts/font1.ttf",
    "font2": "assets/fonts/font2.ttf",
    "font3": "assets/fonts/font3.ttf",
    "font4": "assets/fonts/font4.ttf",
  };

  String fontCss = '';
  for (final key in fontsAssets.keys) {
    final value = fontsAssets[key];
    final fontData = await rootBundle.load(value!);
    final fontUri = getFontUri(fontData, fontMime).toString();
    fontCss += '@font-face { font-family: "$key"; src: url("$fontUri"); }\n';
  }

  print('font is $fontCss');
  return htmlContent.replaceAll("<style>", "<style>$fontCss");
}
