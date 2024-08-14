 import 'package:flutter/material.dart';

import '../../../services/bilan_service.dart';
import '../../../services/cartesianPlane.dart';
import '../../../services/circlePainter.dart';

class HomeSuperAdmin extends StatefulWidget {
  @override
  State<HomeSuperAdmin> createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: Future.wait([
          BilanService.getBetByPeriod("TYPE_PERIOD_DAY"),
          BilanService.getBetByPeriod("TYPE_PERIOD_WEEK"),
          BilanService.getBetByPeriod("TYPE_PERIOD_MONTH"),
          BilanService.getBetByPeriod("TYPE_PERIOD_YEAR"),
          BilanService.getBilanGeneral(),
        ]),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.hasError);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions found'));
          } else {

            Map<String, dynamic> bilanByDay = snapshot.data![0];
            Map<String, dynamic> bilanByWeek = snapshot.data![1];
            Map<String, dynamic> bilanByMonth = snapshot.data![2];
            Map<String, dynamic> bilanByYear = snapshot.data![3];
            Map<String, dynamic> bilanGeneral = snapshot.data![4];
            print(bilanGeneral);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height:30,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40,right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre d'abonnés:",style: TextStyle(color:Colors.blue.shade900 )),
                                    SizedBox(width: 20),
                                    Text(bilanGeneral['nombre_abonnes'].toString(),style: TextStyle(color:Colors.blue.shade900 ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre Marchands:",style: TextStyle(color:Colors.blue.shade100 )),
                                    SizedBox(width: 20),
                                    Text(bilanGeneral['nombre_marchant'].toString(),style: TextStyle(color:Colors.blue.shade100 ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre Assistants:",style: TextStyle(color:Colors.blue.shade100 )),
                                    SizedBox(width: 20),
                                    Text(bilanGeneral['nombre_assistant'].toString(),style: TextStyle(color:Colors.blue.shade100 ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40,left: 40,top:30),
                        child: CustomPaint(
                          size: Size(20, 20),
                          painter: CirclePainter(),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height:30,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40,right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 15),
                                child: Center(child: Text("Pour aujourd'hui "),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre total de pari:",style: TextStyle(color:Colors.blue.shade600 )),
                                    SizedBox(width: 20),
                                    Text(bilanByDay['number_bets'].toString(),style: TextStyle(color:Colors.blue.shade600 ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre  paris gagnés:"),
                                    SizedBox(width: 20),
                                    Text(bilanByDay['number_bet_win'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre paris perdus:"),
                                    SizedBox(width: 20),
                                    Text(bilanByDay['number_bet_lost'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Chiffre d'affaire:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByDay['turnover'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Bénefice:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByDay['profit'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(right: 40,left: 40,top:30),
                        child: CustomPaint(
                          size: Size(20, 20),
                          painter: CirclePainter2(),
                        ),
                      ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height:30,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40,right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 15),
                                child: Center(child: Text('Pour cette semaine '),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre total de pari:",style: TextStyle(color:Colors.blue.shade600 )),
                                    SizedBox(width: 20),
                                    Text(bilanByWeek['number_bets'].toString(),style: TextStyle(color:Colors.blue.shade600 ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre  paris gagnés:"),
                                    SizedBox(width: 20),
                                    Text(bilanByWeek['number_bet_win'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre paris perdus:"),
                                    SizedBox(width: 20),
                                    Text(bilanByWeek['number_bet_lost'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Chiffre d'affaire:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByWeek['turnover'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Bénefice:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByWeek['profit'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40,left: 40,top:30),
                          child: CustomPaint(
                            size: Size(20, 20),
                            painter: CirclePainter2(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height:30,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40,right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 15),
                                child: Center(child: Text('Pour ce mois de Août '),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre total de pari:",style: TextStyle(color:Colors.blue.shade600 )),
                                    SizedBox(width: 20),
                                    Text(bilanByMonth['number_bets'].toString(),style: TextStyle(color:Colors.blue.shade600 ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre  paris gagnés:"),
                                    SizedBox(width: 20),
                                    Text(bilanByMonth['number_bet_win'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre paris perdus:"),
                                    SizedBox(width: 20),
                                    Text(bilanByMonth['number_bet_lost'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Chiffre d'affaire:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByMonth['turnover'].toString()} FCFA",)

                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Bénefice:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByMonth['profit'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40,left: 40,top:30),
                          child: CustomPaint(
                            size: Size(20, 20),
                            painter: CirclePainter2(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height:30,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40,right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,bottom: 15),
                                child: Center(child: Text("Pour l'année "),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0,left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre total de pari:",style: TextStyle(color:Colors.blue.shade600 )),
                                    SizedBox(width: 20),
                                    Text(bilanByYear['number_bets'].toString(),style: TextStyle(color:Colors.blue.shade600 ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre  paris gagnés:"),
                                    SizedBox(width: 20),
                                    Text(bilanByYear['number_bet_win'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Nombre paris perdus:"),
                                    SizedBox(width: 20),
                                    Text(bilanByYear['number_bet_lost'].toString())
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text("Chiffre d'affaire:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByYear['turnover'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Bénefice:",),
                                    SizedBox(width: 20),
                                    Text("${bilanByYear['profit'].toString()} FCFA",)
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40,left: 40,top:30),
                          child: CustomPaint(
                            size: Size(20, 20),
                            painter: CirclePainter2(),
                          ),
                        ),
                      )
                    ],
                  ),

                  // SizedBox(height: 15,),
                  // CartesianPlane(),
                  // SizedBox(height: 15,),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}


