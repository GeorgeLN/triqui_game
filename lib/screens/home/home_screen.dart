
// ignore_for_file: must_be_immutable, prefer_final_fields, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:triqui_game/screens/home/widgets/player_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Current player
  String currentPlayer = "X";

  //Border state to keep track of moves
  final List<String> board = List.filled(9, '');

  //Variable to store the winner
  String winner = '';

  //Flag to indicate a tie
  bool isTie = false;

  //Function to handle a player's move
  player(int index) {
    if (winner != '' || board[index] != '') {
      return; //If the game is already won or the cell is not empty do nothing
    }

    setState(() {
      board[index] = currentPlayer; //Set the current cell to the current player's symbol
      currentPlayer = currentPlayer == 'X' ? currentPlayer = 'O' : currentPlayer = 'X'; //Switch to the one another player
      checkForWinner();      
    });
  }

  //Function for check for a winner or a tie
  checkForWinner() {
    List<List<int>> lines = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ];

    //Check each winning combination
    for (List<int> line in lines) {
      String player1 = board[line[0]];
      String player2 = board[line[1]];
      String player3 = board[line[2]];

      if (player1 == '' || player2 == '' || player3 == '') {
        continue; //If any cell in the combination is empty, skip this combination
      }

      if (player1 == player2 && player2 == player3) {
        setState(() {
          winner = player1; //If all cells in the combination are the same, set the winner
        });

        return;
      }

      //Check for a tie
      if (!board.contains('')) {
        setState(() {
          isTie = true; //If not cells are empty and there's no winner
        });
      }
    }
  }

  //Function to reset the game state and play a new game
  newGame() {
    setState(() {
      board.fillRange(0, 9, ''); //Clear the board
      currentPlayer = 'X';
      winner = ''; //Clear the winner
      isTie = false; //Clear the tie flag
    });
  }

  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueGrey,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              PlayerCard(
                currentPlayer: currentPlayer,
                typePlayer: currentPlayer == 'X' ? 'JUGADOR 1' : 'JUGADOR 2',
                type: currentPlayer == 'X' ? '"X"' : '"O"',
              ),

              //SizedBox(width: size.width * 0.05),

              // PlayerCard(
              //   currentPlayer: currentPlayer,
              //   typePlayer: 'JUGADOR 2',
              //   type: 'O',
              // ),
            ],
          ),

          SizedBox(height: size.height * 0.04),

          //Display the winner message
          if (winner != '') Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "\"$winner\"",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                ' GANA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          //Display tie message
          if (isTie) const Text(
            'EMPATE',
            style: TextStyle(
              color: Colors.red,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),

          //Game board
          Padding(
            padding: const EdgeInsets.all(10),

            child: GridView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    player(index);
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                );  
              },

              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),

              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
            ),
          ),

          //Reset button
          if (winner != '' || isTie) Container(
            width: size.width * 0.8,
            height: size.height * 0.06,
            
            child: ElevatedButton(
              onPressed: newGame,
            
              child: const Text(
                'EMPEZAR DE NUEVO',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
