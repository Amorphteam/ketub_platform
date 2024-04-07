import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حول التطبيق'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          buildDes(
            context,
            'الاجتهاد والتجديد',
            'فصلية متخصصة بقضايا الاجتهاد والتجديد الإسلامي',
            'assets/images/ejtihad_logo.png',
            '''مجلّة (نصوص معاصرة) مجلّة فصليّة، تصدر عن مركز البحوث المعاصرة في بيروت، وهي تعنى بمجال الفكر الديني عموماً.مجلّة (الاجتهاد والتجديد) مجلّةٌ فصليّة، تصدر عن مركز البحوث المعاصرة في بيروت، وهي تعنى بمجال التجديد في الاجتهاد الشرعي والقانوني.
      تأسّست المجلة عام 2006م، برئاسة تحرير الشيخ حيدر حبّ الله، وقد عملت وما تزال على المساهمة في رفد الساحة الفكريّة بالدراسات الجديدة والجريئة والنقديّة في مجال العلوم الشرعيّة المتصلة بالاجتهاد والفقه الإسلامي. وقد تناولت المجلّة الكثير من القضايا الإشكاليّة والحسّاسة، ممّا يتصل بعلم أصول الفقه، وعلم الحديث والرجال، والقانون المقارن، والدراسات الشرعيّة المقارنة بين المذاهب، ومستحدثات المسائل وفقه النوازل وغير ذلك.
      وتعتمد المجلة نهج فتح الباب أمام الآراء المختلفة، فهي تطرح الرأي والرأي الآخر، وتعمل على فتح حوار جادّ بين التوجّهات الفكريّة والتجديديّة في العالم العربي والإسلامي على مستوى الاجتهاد الشرعي، وقد أثارت الكثير من المقالات التي نُشرت في هذه المجلة جدلاً وردود أفعال واسعة، حيث تناولت قضايا بالغة الحساسية، وخالفت الكثير من النتائج الفقهيّة التي كانت وما تزال سائدة في المدارس والجامعات والمعاهد الدينيّة إلى اليوم.
      إنّها بحقّ مجلّة مثيرة للاهتمام، ويمكن من خلالها فتح آفاق جديدة للباحثين والكتّاب وطلاب الدراسات الدينيّة والقانونيّة والشرعيّة.
      ''',
          ),
          buildDes(
            context,
            'نصوص معاصرة',
            'فصلية تعني بالفكر الديني المعاصر',
            'assets/images/nosos_logo.png',
'''مجلّة (نصوص معاصرة) مجلّة فصليّة، تصدر عن مركز البحوث المعاصرة في بيروت، وهي تعنى بمجال الفكر الديني عموماً.
تأسّست المجلة عام 2005م، برئاسة تحرير الشيخ حيدر حبّ الله، وقد عملت وما تزال على ترجمة الدراسات الفكرية والثقافية المتصلة بالشأن الديني عن اللغات غير العربيّة، وتناولت أكثر القضايا إشكاليّةً وحساسيّة ممّا يتصل بفلسفة الدين، وعلم الكلام الجديد، والدراسات الحديثة في مجال القرآنيات، والكلام الديني، وكذلك في مجال القراءات المقارنة فيما يتصل بالفكر الغربي والإسلامي وغير ذلك.
وتعتمد المجلة نهج فتح الباب أمام الآراء المختلفة، فهي تطرح الرأي والرأي الآخر، وتعمل على فتح حوار جادّ بين التوجّهات الفكريّة والتجديديّة في العالم العربي والإسلامي، وقد أثارت الكثير من المقالات التي نُشرت في هذه المجلة جدلاً وردود أفعال واسعة، حيث تناولت قضايا بالغة الحساسية.
إنّها بحقّ مجلّة مثيرة للاهتمام، ويمكن من خلالها فتح آفاق جديدة للباحثين والكتّاب وطلاب الدراسات الدينيّة.
''',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  const url = 'https://www.nosos.net';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: SvgPicture.asset('assets/icons/explore.svg', height: 30,),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () async {
                  const url = 'https://www.amorphteam.com/privay_policy.html';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: SvgPicture.asset('assets/icons/info_circle.svg', height: 30,),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () async {
                  const emailUrl = 'mailto:mdohayni@hotmail.com';
                  if (await canLaunch(emailUrl)) {
                    await launch(emailUrl);
                  } else {
                    throw 'Could not launch $emailUrl';
                  }
                },
                child: SvgPicture.asset('assets/icons/mail.svg', height: 30,),
              ),
            ],
          )],
      ),
    );
  }

  Widget buildDes(BuildContext context, String title, String description, String logo, String fullDescription) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(logo, height: 50,),
          Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
          ),),
          SizedBox(height: 10,),
          Text(description, style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.amberAccent.withOpacity(0.5),)),
          SizedBox(height: 20,),
          Text(fullDescription, style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            height: 2,
          )),
        ],
      );
  }
}
