import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}
var controller = ConfettiController();
List<String> ColRow = ["", "", "", "", "", "", "", "", ""];
List<bool> ColRowTrack = [false,false,false,false,false,false,false,false,false];
int draw =0;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Center(
             child: Text("TIC TAC TOE",style: TextStyle(
               fontFamily: 'Tiny5',
               color: Colors.white,
               fontSize: 50
             ),),
           ),
            SizedBox(
              height: 10,
            ),
            IconButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TicTacToe()) );
            },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
              ),
            icon: Icon(Icons.play_arrow,color: Colors.white,size: 60,),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                  "@Sahil-Thakur-1",style: TextStyle(
                  fontFamily: 'Tiny5',
                  color: Colors.white,
                  fontSize: 30
              )
              ),
            )
          ],
        ),

    );
  }

}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  bool track = true;// true for 0, false for 1
  int counter0 = 0;
  int counter1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text("Scrore of 0",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),),
                      Expanded(
                        child: Text(counter0.toString(),style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50
                        ),),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text("Scrore of X",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                      Expanded(
                        child: Text(counter1.toString(),style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50
                      ),)
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (track == true && ColRow[index]=="") {
                            ColRow[index] = "0";
                            track = false;
                          }
                          else if(ColRow[index]==""){
                            ColRow[index] = "X";
                            track = true;
                          }
                          draw++;
                          CheckForWinner();
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: ColRowTrack[index]==false?Colors.blue[500]:Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(ColRow[index].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40,
                                )),
                          )),
                    );
                  }),
            ),
          ),
          Expanded(
            child: const Text("TIC TAC TOE",style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          ),
          Expanded(
            child: const Text("@Sahil-Thakur-1",style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    );
  }

  void CheckForWinner() {
    // row 1
    if (ColRow[0] == ColRow[1] &&
        ColRow[0] == ColRow[2] &&
        ColRow[0] != "") {
      changecolor(0, 1, 2);
      winner(ColRow[0]);
      print("you win");
    }
    // row 2
    else if (ColRow[3] == ColRow[4] &&
        ColRow[3] == ColRow[5] &&
        ColRow[3] != "") {
      changecolor(3, 4, 5);
      winner(ColRow[3]);
    }
    // row 3
    else if (ColRow[6] == ColRow[7] &&
        ColRow[6] == ColRow[8] &&
        ColRow[6] != "") {
      changecolor(6, 7, 8);
      winner(ColRow[6]);
    }
    // col1
    else if (ColRow[0] == ColRow[3] &&
        ColRow[0] == ColRow[6] &&
        ColRow[0] != "") {
      changecolor(0, 3, 6);
      winner(ColRow[0]);
    }
    // col 2
    else if (ColRow[1] == ColRow[4] &&
        ColRow[1] == ColRow[7] &&
        ColRow[1] != "") {
      changecolor(1, 4, 7);
      winner(ColRow[1]);
    }
    // col 3
    else if (ColRow[2] == ColRow[5] &&
        ColRow[2] == ColRow[8] &&
        ColRow[2] != "") {
      changecolor(2, 5, 8);
      winner(ColRow[2]);
    }
    // left diagonal
    else if (ColRow[0] == ColRow[4] &&
        ColRow[0] == ColRow[8] &&
        ColRow[0] != "") {
      changecolor(0, 4, 8);
      winner(ColRow[0]);
    }
    // right diagonal
    else if (ColRow[2] == ColRow[4] &&
        ColRow[2] == ColRow[6] &&
        ColRow[2] != "") {
      changecolor(2, 6, 4);
      winner(ColRow[2]);
    }
    else if(draw==9){
      winner(ColRow[0]);
    }
  }

  void changecolor(int i ,int j, int k){
    setState(() {
      ColRowTrack[i]=true;
      ColRowTrack[j]=true;
      ColRowTrack[k]=true;
    });
  }

  void winner(String a){
    if(a=='0'&& draw!=9){
      setState(() {
        counter0++;
      });
    }
    else if(draw!=9){
     setState(() {
       counter1++;
     });
    }
    setState(() {
      controller.play();
    });
    showDialog(context: context,builder:(BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.blue[500],
        content: ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
        ),
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          Expanded(
            child: Container(color: Colors.red[200],
                child: TextButton(onPressed: Restart, child: Text("Restart",style: TextStyle(
                  color: Colors.red[900]
                ),))),
          ),
          Expanded(
          child:Container(color: Colors.green[200],
              child: TextButton(onPressed: Replay, child: Text("Re-Match",style: TextStyle(
                color: Colors.green[900]
              ),))))
              ]
          )
        ],
        title: Center(
          child: Text(
            draw==9?"Draw":"winner $a",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        alignment: Alignment.center,
      );
    });
  }
  void Restart(){
     setState(() {
       ColRow = ["", "", "", "", "", "", "", "", ""];
       ColRowTrack = [false,false,false,false,false,false,false,false,false];
       draw =0;
       counter1=0;
       counter0=0;
       Navigator.pop(context);
     });
  }
  void Replay(){
    setState(() {
      ColRow = ["", "", "", "", "", "", "", "", ""];
      ColRowTrack = [false,false,false,false,false,false,false,false,false];
      draw =0;
      Navigator.pop(context);
    });
  }
}
