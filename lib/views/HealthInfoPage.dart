import 'package:corona_tracker/constants/constantColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthInfoPage extends StatefulWidget {
  @override
  _HealthInfoPageState createState() => _HealthInfoPageState();
}

class _HealthInfoPageState extends State<HealthInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 15, right: 15),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Health Tips",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Card(
            elevation: 5,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Image.asset('assets/symptoms.gif'),
              title: Text(
                "Symptoms",
                style: TextStyle(color: color[900], fontSize: 20),
              ),
              subtitle: Text(
                "The COVID-19 affects different people in different ways",
                style: TextStyle(fontSize: 15),
              ),
              children: [
                Text("Most common symptoms:-",style: TextStyle(color: Colors.black87),),
                Text("fever    dry cough     tiredness"),
                Text("Less common symptoms:-",style: TextStyle(color: Colors.black87),),
                Wrap(children: [Text("aches and pains   sore throat    diarrhoea    conjunctivitis        headache      loss of taste or smell              a rash on skin    discolouration of fingers or toes",softWrap: true,)]),
                Text("Serious symptoms:-",style: TextStyle(color: Colors.black87),),
                Wrap(children: [Text("difficulty breathing or shortness of breath\nchest pain or pressure\nloss of speech or movement",softWrap: true,)]),
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Image.asset('assets/mask.jpg'),
              title: Text(
                "Preventive Measures",
                style: TextStyle(color: color[900], fontSize: 20),
              ),
              subtitle: Text(
                "Check how to prevent infection and slow trasmission of COVID-19",
                style: TextStyle(fontSize: 15),
              ),
              children: [
                Text("To prevent the spread of COVID-19:-",style: TextStyle(color: Colors.black87),),
                Wrap(children: [Text("Clean your hands often. Use soap and water, or an alcohol-based hand rub.\nMaintain a safe distance from anyone who is coughing or sneezing\nWear a mask when physical distancing is not possible\nDon’t touch your eyes, nose or mouth.\nCover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.\nStay home if you feel unwell.\nIf you have a fever, cough and difficulty breathing, seek medical attention.")])
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text("Commonly Asked Questions",style: TextStyle(fontSize: 18),),
          Card(
            elevation: 2,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text("What happens to the people who get COVID-19?"),
              children: [Wrap(children: [Text("Among those who develop symptoms, most (about 80%) recover from the disease without needing hospital treatment. About 15% become seriously ill and require oxygen and 5% become critically ill and need intensive care. Complications leading to death may include respiratory failure, acute respiratory distress syndrome (ARDS), sepsis and septic shock, thromboembolism, and/or multiorgan failure, including injury of the heart, liver or kidneys. In rare situations, children can develop a severe inflammatory syndrome a few weeks after infection. ")])],
            ),
          ),
          Card(
            elevation: 2,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text("Who is most at risk of severe illness from COVID-19?"),
              children: [Wrap(children: [Text("People aged 60 years and over, and those with underlying medical problems like high blood pressure, heart and lung problems, diabetes, obesity or cancer, are at higher risk of developing serious illness. However, anyone can get sick with COVID-19 and become seriously ill or die at any age. ")])],
            ),
          ),
          Card(
            elevation: 2,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text("Are there log term effects of COVID-19?"),
              children: [Wrap(children: [Text("Some people who have had COVID-19, whether they have needed hospitalization or not, continue to experience symptoms, including fatigue, respiratory and neurological symptoms. WHO is working with our Global Technical Network for Clinical Management of COVID-19, researchers and patient groups around the world to design and carry out studies of patients beyond the initial acute course of illness to understand the proportion of patients who have long term effects, how long they persist, and why they occur.  These studies will be used to develop further guidance for patient care.")])],
            ),
          ),
          Card(
            elevation: 2,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text("When should I get a test of COVID-19?"),
              children: [Wrap(children: [Text("Anyone with symptoms should be tested, wherever possible. People who do not have symptoms but have had close contact with someone who is, or may be, infected may also consider testing – contact your local health guidelines and follow their guidance. While a person is waiting for test results, they should remain isolated from others. Where testing capacity is limited, tests should first be done for those at higher risk of infection, such as health workers, and those at higher risk of severe illness such as older people, especially those living in seniors’ residences or long-term care facilities.")])],
            ),
          ),
          Card(
            elevation: 2,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text("How long does it takes to develop the symptoms?"),
              children: [Wrap(children: [Text("The time from exposure to COVID-19 to the moment when symptoms begin is, on average, 5-6 days and can range from 1-14 days. This is why people who have been exposed to the virus are advised to remain at home and stay away from others, for 14 days, in order to prevent the spread of the virus, especially where testing is not easily available.")])],
            ),
          ),
          Card(
            elevation: 2,
            child: ExpansionTile(
              childrenPadding: EdgeInsets.all(8.0),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text("Are antibiotics effective in preventing or treating COVID-19?"),
              children: [Wrap(children: [Text("Antibiotics do not work against viruses; they only work on bacterial infections. COVID-19 is caused by a virus, so antibiotics do not work. Antibiotics should not be used as a means of prevention or treatment of COVID-19. In hospitals, physicians will sometimes use antibiotics to prevent or treat secondary bacterial infections which can be a complication of COVID-19 in severely ill patients. They should only be used as directed by a physician to treat a bacterial infection.")])],
            ),
          ),
        ]),
      ),
    );
  }
}
