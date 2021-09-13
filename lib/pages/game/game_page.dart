import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);



  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Game _game;
  final _controller = TextEditingController();
  String? _guessNumber;
  String? _feedback;
  List <String>  _text = [];



  @override
  void initState() {
    super.initState();
    _game = Game();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _Winner(){
    if(_feedback == 'CORRECT!'){
      return true;
    }else{
      return false;
    }
  }

  _NewGame() {
    setState(() {
      _game = Game();
      _guessNumber = null;
      _feedback = null;
      _text.clear();
    });
  }


  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: const DecorationImage(
              image: const AssetImage("assets/images/b.jpg"), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            // column หลักเต็มจอ
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // column รูปภาพและข้อความด้านบน
                _buildHeader(),
                // Text ด้านล่างรูป
                _buildMainContent(),
                // TextField ให้ User กรอกข้อมูล
                _buildInputPamel(),
              ], // children ของทั้งหมด
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo_number.png',
          width: 300.0, // 96 = 1 inch
        ),
        Text(
          'GUESS THE NUMBER',
          style: GoogleFonts.mali(
              fontSize: 30.0,
              color: Colors.brown.shade800,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return _guessNumber == null
        ? Text(
            'WHAT GUESS THE NUMBER ?\n' '1-100',
            style: GoogleFonts.mali(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        : _Winner() ? Column(
            children: [
              Text(
                _guessNumber!,
                style: GoogleFonts.mali(
                    fontSize: 50.0, fontWeight: FontWeight.bold),
              ),
              Text(_feedback!,
                  style: GoogleFonts.mali(
                      color: Colors.lightBlue.shade900,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold)),
              Column (
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.orange.shade200,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                          _NewGame();

                      },

                      child: Text('NewGame',
                          style: GoogleFonts.mali(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)
                      )
                  ),
                ],
              )
            ],
          )
             :
    Column(
      children: [
        Text(
          _guessNumber!,
          style: GoogleFonts.mali(
              fontSize: 50.0, fontWeight: FontWeight.bold),
        ),
        Text(_feedback!,
            style: GoogleFonts.mali(
                color: Colors.lightBlue.shade900,
                fontSize: 40.0,
                fontWeight: FontWeight.bold)),
        /*Column (
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.orange.shade200,
                  onSurface: Colors.grey,
                ),
                onPressed: () {

                },

                child: Text('NewGame',
                    style: GoogleFonts.mali(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)
                )
            ),
          ],
        )*/
      ],
    );
  }

  Widget _buildInputPamel() {
    return Card(
      color: Colors.pink.shade50,
      elevation: 20.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              cursorColor: Colors.yellow,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                isDense: true,
                // กำหนดลักษณะเส้น border ของ TextField ในสถานะปกติ
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                // กำหนดลักษณะเส้น border ของ TextField เมื่อได้รับโฟกัส
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Enter the number here',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16.0,
                ),
              ),
            )),
            TextButton(
              onPressed: () {
                setState(() {
                  _guessNumber = _controller.text;
                  int? guess = int.tryParse(_guessNumber!);

                  _text.add(_guessNumber!);

                  if (guess != null) {
                    var result = _game.doGuess(guess);

                    if (result == 0) {
                      _feedback = 'CORRECT!';
                      FocusScope.of(context).unfocus();
                      _showMaterialDialog(
                          'GoodJob! 💯 ',
                          '🎄 Answer = $_guessNumber \n'
                          '🌺 Total Guess = ${_game.totalGuessses}\n\n\n'
                          '🌈 ${_text} 🌈'
                      );

                    } else if (result == 1) {
                      _feedback = 'TOO HIGH!';
                    } else {
                      _feedback = 'TOO LOW!';
                    }
                  }
                  _controller.clear();

                });
              },
              child: Text(
                'GUESS',
                style: GoogleFonts.mali(
                    color: Colors.brown,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
