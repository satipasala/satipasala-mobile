import 'package:flutter/material.dart';
import 'package:mobile/Firebase/model/Event.dart';
import '../../../Styles/AppStyles.dart';
import 'EventDetails.dart';

class EventCard extends StatelessWidget {
  Event event;
  EventCard(this.event);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetails(event)),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                "https://media.istockphoto.com/vectors/yoga-different-people-vector-id1166219231?k=6&m=1166219231&s=612x612&w=0&h=BXil_lf2N2GXl_vPx04QCz4i7Xx90Z8SKy6cLq4yD_M=",
                height: 90.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 100,
            child: Text(
              event.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: textColor),
            ),
          )
        ],
      ),
    );
  }
}
