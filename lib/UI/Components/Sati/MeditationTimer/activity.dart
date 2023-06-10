import 'package:flutter/material.dart';
import 'dart:async';

class MyActivity extends StatefulWidget {
  @override
  _MyActivityState createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  List<String> week= ["S","M","T","W","T","F","S"];
  double progressLevel=0;
  late Timer _timer;
  void progressAnimation(){


    
      for(int i=0;i<100;){
            _timer = new Timer(const Duration(milliseconds: 200), () {
              setState(() {
                i++;
                progressLevel = progressLevel+1;
                    
    });

});
      
      }
  
  }

    @override
  void initState() {
    progressAnimation();
    
    super.initState();
  }

  Widget progressBar(context,int index){
    
    String day = week[index];
     
      return Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                    Container(
                    height: 150.0,
                    width: 10.0,
                   decoration: BoxDecoration(
                        
                          color: Colors.white, shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(10)),
                    
                  ),
                    Container(
                      height: progressLevel,
                      width: 10.0,
                      decoration: BoxDecoration(
                        
                          color: Colors.teal, shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(10)),
                    ),
                  ],),
                  
                  Text(day,style: const TextStyle(color: Colors.black54,fontFamily: "Montserrat-Medium"),)
                ],
              ),
      );
    
   
  }

  Widget meditationActivity(){
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width*0.85,
      decoration: BoxDecoration(color: Colors.tealAccent,shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            
              Text("Mindful Sitting",style: TextStyle(fontSize: 20,color: Colors.black54,fontFamily: "Montserrat-Medium"),),
            
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
       Padding(
         padding: const EdgeInsets.only(top:20.0),
         child: new  Container(
            decoration: BoxDecoration(color: Colors.tealAccent,shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(10)),
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width*0.85,
            child: 
              
      ListView.builder(

        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        itemCount: week.length,
        itemBuilder: (BuildContext context, int index) {
          return progressBar(context,index);
        },
      )
           
          ),
       ),
       SizedBox(height: 30,),
       Text("This Weeks Activty",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 30.0,
                          fontFamily: "Montserrat-Medium",
                          letterSpacing: 1.0,
                        )),
        SizedBox(height: 30,),

        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              meditationActivity()
            ],
          ),
        )
      ],
    );
  }
}
