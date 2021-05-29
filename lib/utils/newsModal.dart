import 'dart:convert';
import 'package:corona_tracker/modals/NewsModal.dart';
import 'package:http/http.dart' as http;
class NewsModalList{

  List<NewsModal> news=<NewsModal>[];

  Future<List> getNewsData()async{
    var url =Uri.parse("https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/news/get-coronavirus-news/0");
    var header={
      "x-rapidapi-key": "cb32e83aadmshf7538630f70d9ccp1422d9jsn152d1c5be9f5",
      "x-rapidapi-host": "vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com",
      "useQueryString": "true"
    };

    var response=await http.get(url,headers: header);

    var json_decode= jsonDecode(response.body)["news"];

    if(response.statusCode>=200 && response.statusCode<=205){
      json_decode.forEach((element){
        if(element["urlToImage"]!=null && element["content"]!=null){
          NewsModal newsmodal=new NewsModal(
            title: element["title"],
            reference: element["reference"],
            url: element["link"],
            urlToImage: element["urlToImage"],
            publishedAt: element["pubDate"],
            content: element["content"]
          );
          news.add(newsmodal);
        }
      });
    }
  }
}