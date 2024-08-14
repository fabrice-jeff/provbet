import 'package:flutter/material.dart';
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = Colors.blue.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30; // La moitié de la taille de la bordure

    Paint paint2 = Paint()
      ..color = Colors.blue.shade900!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30; // La moitié de la taille de la bordure

    // Dessine la première moitié du cercle (bleu clair)
    canvas.drawArc(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
      1.5708, // -90 degrés en radians
      3.14159, // 180 degrés en radians
      false,
      paint1,
    );

    // Dessine la deuxième moitié du cercle (bleu foncé)
    canvas.drawArc(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
      -1.5708, // 90 degrés en radians
      4.14159, // 180 degrés en radians
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class CirclePainter2 extends CustomPainter {
  @override
void paint(Canvas canvas, Size size) {
  Paint paint1 = Paint()
    ..color = Colors.blue.shade600
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30; // La moitié de la taille de la bordure

  Paint paint2 = Paint()
    ..color = Colors.blue.shade900!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30; // La moitié de la taille de la bordure

  Paint paint3=Paint()
    .. color = Colors.orange.shade900!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30;

  Paint paint4=Paint()
    .. color = Colors.green.shade700!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30;


  Paint paint5=Paint()
    .. color = Colors.yellow!
    ..style = PaintingStyle.stroke
    ..strokeWidth = 30;


  // Dessine la première moitié du cercle (bleu clair)
  canvas.drawArc(
    Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
    -1.5708, // -90 degrés en radians
    3.14159, // 180 degrés en radians
    false,
    paint1,
  );
  // Dessine la deuxième moitié du cercle (bleu foncé)
  canvas.drawArc(
    Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
    -2.5, // 90 degrés en radians
    0.99999, // 180 degrés en radians
    false,
    paint2,
  );

  canvas.drawArc(
    Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
   1.0, // -90 degrés en radians
    2.80, // 180 degrés en radians
    false,
    paint3,
  );

  // Dessine la deuxième moitié du cercle (bleu foncé)
  canvas.drawArc(
    Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
    1.0, // 90 degrés en radians
    1.14159, // 180 degrés en radians
    false,
    paint4,
  );
  canvas.drawArc(
    Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 80, height: 80),
    0.0, // 90 degrés en radians
    1.14159, // 180 degrés en radians
    false,
    paint5,
  );
}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
  return false;
}
}