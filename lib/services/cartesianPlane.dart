//
// import 'package:flutter/material.dart';
// class CartesianPlane extends StatelessWidget {
//   final List<Map<String, dynamic>> data = [
//     {'country': 'France', 'subscribers': 1000},
//     {'country': 'USA', 'subscribers': 1500},
//     {'country': 'Germany', 'subscribers': 1200},
//     {'country': 'Japan', 'subscribers': 800},
//     {'country': 'Brazil', 'subscribers': 900},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(300, 300),
//       painter: CartesianPlanePainter(data: data),
//     );
//   }
// }
//
// class CartesianPlanePainter extends CustomPainter {
//   final List<Map<String, dynamic>> data;
//   CartesianPlanePainter({required this.data});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint axisPaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2.0;
//
//     final double xOffset = 40;
//     final double yOffset = 20;
//
//     // Draw X and Y axes
//     canvas.drawLine(Offset(xOffset, size.height - yOffset), Offset(size.width, size.height - yOffset), axisPaint);
//     canvas.drawLine(Offset(xOffset, 0), Offset(xOffset, size.height - yOffset), axisPaint);
//
//     // Draw axis labels
//     final TextPainter textPainter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );
//
//     // Draw X axis labels (subscribers)
//     for (int i = 0; i <= 5; i++) {
//       final int subscribers = i * 500;
//       textPainter.text = TextSpan(text: '$subscribers', style: TextStyle(color: Colors.black, fontSize: 12));
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(xOffset + i * 50 - textPainter.width / 2, size.height - yOffset + 5));
//     }
//
//     // Draw Y axis labels (countries)
//     for (int i = 0; i < data.length; i++) {
//       final String country = data[i]['country'];
//       textPainter.text = TextSpan(text: country, style: TextStyle(color: Colors.black, fontSize: 12));
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(xOffset - textPainter.width - 5, size.height - yOffset - i * 40 - textPainter.height / 2));
//     }
//
//     // Plot points
//     final Paint pointPaint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = 4.0;
//
//     for (int i = 0; i < data.length; i++) {
//       final int subscribers = data[i]['subscribers'];
//       final double x = xOffset + (subscribers / 500) * 50;
//       final double y = size.height - yOffset - i * 40;
//       canvas.drawCircle(Offset(x, y), 4.0, pointPaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// lib/main.dart
import 'package:flutter/material.dart';

class CartesianPlane extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'country': 'France', 'subscribers': 0},
    {'country': 'USA', 'subscribers': 1500},
    {'country': 'Germany', 'subscribers': 1200},
    {'country': 'Japan', 'subscribers': 800},
    {'country': 'Brazil', 'subscribers': 900},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: CartesianPlanePainter(data: data),
    );
  }
}

class CartesianPlanePainter extends CustomPainter {
  final List<Map<String, dynamic>> data;
  CartesianPlanePainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axisPaint = Paint()
      ..color = Colors.blue.shade900
      ..strokeWidth = 2.0;

    final Paint bandPaint = Paint()
      ..color = Colors.green.shade900
      ..style = PaintingStyle.fill;

    final double xOffset = 40;
    final double yOffset = 20;
    final double bandHeight = 20;

    // Draw X and Y axes
    canvas.drawLine(Offset(xOffset, size.height - yOffset), Offset(size.width, size.height - yOffset), axisPaint);
    canvas.drawLine(Offset(xOffset, 0), Offset(xOffset, size.height - yOffset), axisPaint);

    // Draw axis labels
    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw X axis labels (subscribers)
    for (int i = 0; i <= 5; i++) {
      final int subscribers = i * 500;
      textPainter.text = TextSpan(text: '$subscribers', style: TextStyle(color: Colors.black, fontSize: 12));
      textPainter.layout();
      textPainter.paint(canvas, Offset(xOffset + i * 50 - textPainter.width / 2, size.height - yOffset + 5));
    }

    // Draw Y axis labels (countries)
    for (int i = 0; i < data.length; i++) {
      final String country = data[i]['country'];
      textPainter.text = TextSpan(text: country, style: TextStyle(color: Colors.blue.shade700, fontSize: 12));
      textPainter.layout();
      textPainter.paint(canvas, Offset(xOffset - textPainter.width - 5, size.height - yOffset - i * 40 - textPainter.height / 2));
    }

    // Plot horizontal bands
    for (int i = 0; i < data.length; i++) {
      final int subscribers = data[i]['subscribers'];
      final double x = xOffset;
      final double y = size.height - yOffset - i * 40 - bandHeight / 2;
      final double bandWidth = (subscribers / 2500) * (size.width - xOffset);
      canvas.drawRect(Rect.fromLTWH(x, y, bandWidth, bandHeight), bandPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
