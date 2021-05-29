import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:corona_tracker/modals/NewsModal.dart';
import 'package:corona_tracker/utils/newsModal.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override

  List<NewsModal> newsmodalslist=<NewsModal>[];
  NewsModalList newsList=NewsModalList();
  bool isfetching;
  void initState(){
    super.initState();
    isfetching=newsList.news.isEmpty;
    print(isfetching);
    print(newsList.news);
    isfetching?fetchCategoryData():null;
  }

  fetchCategoryData()async{
    await newsList.getNewsData();
    setState(() {
      newsmodalslist=newsList.news;
      print(newsmodalslist);
      isfetching=!isfetching;
    });
  }

  Widget build(BuildContext context) {
    return isfetching?Center(child: CircularProgressIndicator(),):Container(
      child: ListView.builder(
        itemCount: newsmodalslist.length,
        itemBuilder: (context, index) {
          return descriptionTile(
            newsmodalslist[index].title,
            newsmodalslist[index].content,
            newsmodalslist[index].urlToImage,
            newsmodalslist[index].url,
          );
        },
      ),
    );
  }
}
class descriptionTile extends StatelessWidget {
  @override
  final String title, subtitle, imageurl,url;

  descriptionTile(this.title, this.subtitle, this.imageurl,this.url);
  Future _launched;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: ()=>_launchInWebViewOrVC(this.url),
          child: Column(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  imageurl,
                  errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                    return Container(child: Image.asset('assets/worldmap.jpg'),);
                  },
                  fit: BoxFit.fill,
                )
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black,fontSize: 15),
              ),
              Container(
                child: Text(
                  subtitle,
                  style: TextStyle(color:Colors.black54),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ));
  }
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}