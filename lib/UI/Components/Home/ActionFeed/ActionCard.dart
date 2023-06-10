import 'package:flutter/material.dart';

import 'DescriptionWidget.dart';

class ActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sameera Roshan",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                  Text("1 Oct 2020",
                      style: TextStyle(fontSize: 14, color: Colors.grey))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(
              "https://media.istockphoto.com/vectors/yoga-different-people-vector-id1166219231?k=6&m=1166219231&s=612x612&w=0&h=BXil_lf2N2GXl_vPx04QCz4i7Xx90Z8SKy6cLq4yD_M=",
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.filter_vintage,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Level 01",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Text(
                "#tags",
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.9,
            child: DescriptionTextWidget(
                text:
                    "this is a sample text to test out the description widget feature and the show more button feature testing testing testing"),
          )
        ],
      ),
    );
  }
}
