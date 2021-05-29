import 'package:flutter/material.dart';
import 'package:corona_tracker/modals/NewsModal.dart';
import 'package:corona_tracker/utils/newsModal.dart';
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override

  List<NewsModal> newsmodalslist=<NewsModal>[];
  void initState(){
    super.initState();
    fetchCategoryData();
  }

  fetchCategoryData()async{
    NewsModalList newsList=NewsModalList();
    await newsList.getNewsData();
    setState(() {
      newsmodalslist=newsList.news;
      print(newsmodalslist);
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: newsmodalslist.length,
        itemBuilder: (context, index) {
          return descriptionTile(
            newsmodalslist[index].title,
            newsmodalslist[index].content,
            newsmodalslist[index].urlToImage,
          );
        },
      ),
    );
  }
}
class descriptionTile extends StatelessWidget {
  @override
  final String title, subtitle, imageurl;

  descriptionTile(this.title, this.subtitle, this.imageurl);

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
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
        ));
  }
}