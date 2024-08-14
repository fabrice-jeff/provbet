import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onPlayPressed;

  const HomePage({Key? key, required this.onPlayPressed}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/boules.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.dstATop,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 160,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/boule_1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Jeu de Boule",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: widget.onPlayPressed,
                                child: Text('Jouer'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.blue.shade900,
                                  disabledForegroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 2.0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            )),
                        Center(
                            child: Text(
                              "Bientôt disponible",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 21,
                              ),
                            )),
                        Container(
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 140,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/jeudee.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Jeu de Dés",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 160,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/roulette.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Roulette",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 130,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('assets/images/carte.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cartes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget {
//   final VoidCallback onPlayPressed;
//
//   const HomePage({Key? key, required this.onPlayPressed}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/boules.jpg'),
//                   fit: BoxFit.cover,
//                   colorFilter: ColorFilter.mode(
//                     Colors.black.withOpacity(0.5),
//                     BlendMode.dstATop,
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   buildGameContainer(
//                     image: 'assets/images/boule_1.jpg',
//                     title: 'Jeu de Boule',
//                     onPlayPressed: widget.onPlayPressed,
//                   ),
//                   buildStatusRow(),
//                   buildGameContainer(
//                     image: 'assets/images/jeudee.jpg',
//                     title: 'Jeu de Dés',
//                   ),
//                   SizedBox(height: 20),
//                   buildGameContainer(
//                     image: 'assets/images/roulette.jpg',
//                     title: 'Roulette',
//                   ),
//                   SizedBox(height: 20),
//                   buildGameContainer(
//                     image: 'assets/images/carte.jpg',
//                     title: 'Cartes',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Container buildGameContainer({required String image, required String title, VoidCallback? onPlayPressed}) {
//     return Container(
//       height: 150,
//       width: 380,
//       decoration: BoxDecoration(
//         color: Colors.blue.shade900,
//         borderRadius: BorderRadius.circular(25.0),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: 160,
//             width: 200,
//             decoration: BoxDecoration(
//               color: Colors.blue.shade900,
//               borderRadius: BorderRadius.circular(25.0),
//               image: DecorationImage(
//                 image: AssetImage(image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 if (onPlayPressed != null) ...[
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: onPlayPressed,
//                     child: Text('Jouer'),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.blue.shade900,
//                       disabledForegroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       textStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         side: BorderSide(
//                           color: Colors.white,
//                           width: 2.0,
//                           style: BorderStyle.solid,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Padding buildStatusRow() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             height: 4,
//             width: 60,
//             decoration: BoxDecoration(
//               color: Colors.blueGrey,
//             ),
//           ),
//           Center(
//             child: Text(
//               "Bientôt disponible",
//               style: TextStyle(
//                 color: Colors.blueGrey,
//                 fontSize: 21,
//               ),
//             ),
//           ),
//           Container(
//             height: 4,
//             width: 60,
//             decoration: BoxDecoration(
//               color: Colors.blueGrey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
