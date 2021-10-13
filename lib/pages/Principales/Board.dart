import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/preferencias/preferencias_usuario.dart';

import 'package:productos_app/models/models.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/Puzzle/puzzle.dart';
import 'package:productos_app/widgets/widgets.dart';


class BoardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final scoreService = Provider.of<ScoreService>(context);

    return ChangeNotifierProvider(
      create: (_) => FormScoreProvider(scoreService.score!),
      child: Board(),
    );  
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {

  

  var numbers = [
    0, 
    1, 
    2, 
    3, 
    4, 
    5, 
    6, 
    7, 
    8, 
    9, 
    10, 
    11, 
    12, 
    13, 
    14, 
    15
    ];

    Map< int , String> imagenes = {
      0  : "https://1.bp.blogspot.com/-Cmymj4dacLA/YVt0usvxFqI/AAAAAAAAAU0/8act-J0hc9UtgiGylot-Pa4bNXrsQMNswCLcBGAsYHQ/s0/imagen_16.jpg",
      1  : "https://1.bp.blogspot.com/-HCpI6W7vmT4/YVt0srVFxEI/AAAAAAAAAUY/zG58hA7Pt6c3gaRyax_zUAcaIlnDIw19gCLcBGAsYHQ/s0/imagen_1.jpg",
      2  : "https://1.bp.blogspot.com/-4XBlo66N78g/YVt0uml9OWI/AAAAAAAAAU4/dUCQPwgT4QIKaOkTe6fTSfaUwVDFjI-MQCLcBGAsYHQ/s0/imagen_2.jpg",
      3  : "https://1.bp.blogspot.com/-yDQlWy2XYo8/YVt0vdkHCJI/AAAAAAAAAU8/wSLBvEMJ2oIcZHcHtbfTuWJ_gPqat8JrACLcBGAsYHQ/s0/imagen_3.jpg",
      4  : "https://1.bp.blogspot.com/-1LDEDUbLLqY/YVt0vpf1_zI/AAAAAAAAAVA/8VxamQU3OXwq_jjIJPBf1IMw_kruGczJACLcBGAsYHQ/s0/imagen_4.jpg",
      5  : "https://1.bp.blogspot.com/-S7vLbEiRPpE/YVt0vm_0xaI/AAAAAAAAAVE/Tb-5eB2PoU43qfbIpDulx-2qM4Cx3oH3gCLcBGAsYHQ/s0/imagen_5.jpg",
      6  : "https://1.bp.blogspot.com/-GPJsmkvrWb8/YVt0wbzdHpI/AAAAAAAAAVI/cv5iIl8BswcTdY1rBVQGrMdFdqQ6x7jZgCLcBGAsYHQ/s0/imagen_6.jpg",
      7  : "https://1.bp.blogspot.com/-ARC_-TIPclI/YVt0wmmgRTI/AAAAAAAAAVM/XOUOrwYpb2kOBw8q10k7w3mGF5JCaU8wACLcBGAsYHQ/s0/imagen_7.jpg",
      8  : "https://1.bp.blogspot.com/-GH0ArNLQAQ0/YVt0xOG4vTI/AAAAAAAAAVQ/AtJxLLawrTcE6IoFZXHyGXNeWTymY75fQCLcBGAsYHQ/s0/imagen_8.jpg",
      9  : "https://1.bp.blogspot.com/-Vx_F-RhbntQ/YVt0xf_qVjI/AAAAAAAAAVU/dYPicfiJpk8Rc-RMdohooiAdxTclaNG6gCLcBGAsYHQ/s0/imagen_9.jpg",
      10 : "https://1.bp.blogspot.com/-IsBEMgkqsXE/YVt0so615VI/AAAAAAAAAUg/F92AHqqdX4M6aIWtH66eSv-sD8KCpPOfgCLcBGAsYHQ/s0/imagen_10.jpg",
      11 : "https://1.bp.blogspot.com/-DSir8DmWevQ/YVt0sjfk7AI/AAAAAAAAAUc/fH0XnqCqu_8ujoadBu2Qolppmo1pV6lAQCLcBGAsYHQ/s0/imagen_11.jpg",
      12 : "https://1.bp.blogspot.com/-YO_0-aeDGlo/YVt0s_MQ24I/AAAAAAAAAUk/MD-JTFZ8IHwHmxwA4cvarZI_PF-IgTF_gCLcBGAsYHQ/s0/imagen_12.jpg",
      13 : "https://1.bp.blogspot.com/-kg4Mti8Daxg/YVt0tWEfy6I/AAAAAAAAAUo/tIruYv6ePTkQtXBGvZBLG5084_8LFRr2wCLcBGAsYHQ/s0/imagen_13.jpg",
      14 : "https://1.bp.blogspot.com/-GD-UwDmcmP4/YVt0uJsUJSI/AAAAAAAAAUs/2Yuf7db9cN0XUBzFsSuRFoLUjK7Az0MqACLcBGAsYHQ/s0/imagen_14.jpg",
      15 : "https://1.bp.blogspot.com/-q7FMe8wB8lE/YVt0uUiHM5I/AAAAAAAAAUw/FClePcm-vkYFl9ag2perDFUUPho0SF_uQCLcBGAsYHQ/s0/imagen_15.jpg",
    };



  int move = 0;

  final pref = PreferenciasUsurario();


  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

  final scoreService = Provider.of<ScoreService>(context);

  

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: MyTitle(size),
        foregroundColor: Colors.black54,
        centerTitle: true,
      ),
      
      body: Container(
        height: size.height,
        color:Colors.white,
        // pref.getColor ? MyColors.colorRosa : MyColors.colorAzul,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Menu(reset, move, secondsPassed, size),

              ImageDialog(),

                ],
              ),
              Grid(numbers, size, clickGrid, imagenes),
              SizedBox(height: size.height * 0.02),
              ResetButton(reset, "Reiniciar"),
              Divider(),
              
              TableScore( scoreService.score!),
              SizedBox(height: size.height * 0.03),
              

            ],
          ),
        ),
      ),
    );
  }
  
  void clickGrid(index ) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {      
    if (isSorted(numbers)) {
      isActive = false;

      showDialog(
          context: context,
          builder: (BuildContext context) {

            final scoreService = Provider.of<ScoreService>(context);

          int tiempo = scoreService.score!.tiempo;
            
            return SingleChildScrollView(

              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: tiempo > secondsPassed ? 450 : 300,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: tiempo > secondsPassed
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
            
                        Text("Ganastee!!",
                          style: TextStyle(fontSize: 30 ,
                          fontFamily: 'RacingSansOne'), textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 5),
            
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Movimientos:'),
                                Text('$move' , style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                                  
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Tiempo:'),
                                Text('$secondsPassed Seg' ,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 5),
            
                        FormScore(move, secondsPassed),
                       
                      ],
                    )
            
                    : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Completado!!",
                                style: TextStyle(
                                    fontSize: 30, fontFamily: 'RacingSansOne'),
                                textAlign: TextAlign.center,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Movimientos:'),
                                      Text(
                                        '$move',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Tiempo:'),
                                      Text(
                                        '$secondsPassed Seg',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                                Column(
                                  children: [
                                    Text(
                                      'Siguen jugando para superar a: ',
                                      textAlign: TextAlign.center,
                                    ),
                                    Text('${scoreService.score!.nombre}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          }
        );
    }
  }
}

class TableScore extends StatelessWidget {

  final Score score;

  const TableScore(this.score);


  @override
  Widget build(BuildContext context) {

  final pref = PreferenciasUsurario();

  final scoreService = Provider.of<ScoreService>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
             
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Container(
                width: 50,
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("Mejor Puntuacion",
                    style: TextStyle(fontSize: 20, fontFamily: 'RacingSansOne')),
              ),

              IconButton(
                onPressed: () {
                  scoreService.loadScore();
                }, 
                icon: Icon(Icons.rotate_left_rounded, color: pref.getColor ? MyColors.colorRosa : MyColors.colorAzul,))
            ],
          ),

          Table(
            
            children: [
              TableRow(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.grey.shade200,
                    Colors.grey.shade300
                  ])),
                  children: [
                    Text(
                      'Nombre',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Movimientos',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tiempo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
              TableRow(children: [
                Text(
                  score.nombre,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${score.movimientos}',
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${score.tiempo} Seg',
                  textAlign: TextAlign.center,
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        showImage(context);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black45)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            placeholder: AssetImage('assets/gato_load.gif'), 
            image: NetworkImage('https://1.bp.blogspot.com/-LcHZwLd4SY4/YVyT0tNmf7I/AAAAAAAAAV8/AS-4SnQzZB0fdgM2pOOcPtaIPohd6iF9ACLcBGAsYHQ/s16000/Logo_ancho_juego.jpg')),
        ),
      ),
    );
  }

  void showImage(context) {
     showDialog(
        context: context,
        builder: (BuildContext context) {

      final pref = PreferenciasUsurario();

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: BoxDecoration(
              color:  pref.getColor ? MyColors.colorRosa : MyColors.colorAzul,

                borderRadius: BorderRadius.circular(20)
              ),
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network('https://1.bp.blogspot.com/-LcHZwLd4SY4/YVyT0tNmf7I/AAAAAAAAAV8/AS-4SnQzZB0fdgM2pOOcPtaIPohd6iF9ACLcBGAsYHQ/s16000/Logo_ancho_juego.jpg' , fit: BoxFit.cover,)),

                  ],
                ),
              ),
            ),
          );
        });
  }
}