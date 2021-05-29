import 'package:flutter/material.dart';

class homePanel extends StatelessWidget {
  String imrURL, headline, subheading, news;
  StatelessWidget nextPage;
  homePanel(this.imrURL, this.headline, this.subheading, this.news, this.nextPage);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(right: 22.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage)
            );
          },
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(this.imrURL),
                  fit: BoxFit.cover,
                  scale: 2.0,
                )
            ),
            width: 310.0,
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headline,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 22.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Column(),
                      SizedBox(height: 3.0,),
                      Text(
                          subheading,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ))
                    ]
                )
            ),
          ),
        )
    );
  }
}

