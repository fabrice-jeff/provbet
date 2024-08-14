import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoriquedeTranslationClient extends StatefulWidget {
  const HistoriquedeTranslationClient({Key? key}) : super(key: key);

  @override
  State<HistoriquedeTranslationClient> createState() => _HistoriquedeTranslationClientState();
}

class _HistoriquedeTranslationClientState extends State<HistoriquedeTranslationClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historique des Translation',style: TextStyle(color:Colors.white ),),
        backgroundColor: Colors.blue.shade900,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
          children: [
      Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/boules.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2),
          BlendMode.dstATop,
          ),
          ),
        ),
        ),
            SizedBox(height: 10,),
            SingleChildScrollView(
             scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                    child: Container(
                      height: 110,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      //child: Center(child: Text('Bonjour',style: TextStyle(color: Colors.white,fontSize: 15),),),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Positioned(
                            top: 15,
                              left: 50,
                              right: 50,
                              child: Text('12/06/2023. 10h 30',style: TextStyle(color: Colors.white,fontSize: 15),)
                          ),
                          SizedBox(height: 10,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 51.0),
                                child: Text('Marchand: Jean Michel',style: TextStyle(color: Colors.white,fontSize: 15),
                              ),),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text('Type: Retrait',style: TextStyle(color: Colors.white,fontSize: 15) ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text("5000 F CFA",style: TextStyle(color: Colors.white,fontSize: 25)),
                                  )
                                ],
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                    child: Container(
                      height: 110,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),


                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                    child: Container(
                      height: 110,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                    child: Container(
                      height: 110,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),

                ],
              ),
            ),
        ]
       ),
    );
  }
}

