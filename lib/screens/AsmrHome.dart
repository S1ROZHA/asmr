import 'package:flutter/material.dart';
import 'package:asmr/screens/player/player.dart';

class AsmrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(19, 18, 24, 1.0),
      body: ListView(
        children: <Widget> [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'ASMR Ear Eating & Licking',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  videoCard(context),
                ],
              ),
            ),
          ],
      ),
    );
  }

  Widget videoCard(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Player(),
          ),
        );
      },
      child: Column(
        children: [
          Card(
            elevation: 0.0,
            child: Image.asset(
              "assets/images/hq720.png",
              fit: BoxFit.fill,
              height: 202,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/unnamed.jpg"),
              radius: 20,
            ),
            title: Text(
              "ASMR Ear Licking 3Dio / АСМР Ликинг",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "tangerine",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}