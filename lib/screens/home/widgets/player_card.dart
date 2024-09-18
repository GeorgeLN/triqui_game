
import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.currentPlayer,
    required this.typePlayer,
    required this.type,
  });

  final String currentPlayer;
  final String typePlayer;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: currentPlayer == 'X'
          ? Colors.teal
          : Colors.green,
    
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
    
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3,
          ),
        ],
      ),
    
      child: Padding(
        padding: const EdgeInsets.all(10),
    
        child: Column(
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
              size: 55,
            ),
    
            const SizedBox(height: 10),
    
            Text(
              typePlayer,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
    
            const SizedBox(height: 10),
    
            Text(
              type,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}