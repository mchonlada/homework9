import 'dart:math';

class Game{
  final int _anwer;
  int _totalGuesses = 0;

  Game() : _anwer = Random().nextInt(100)+1{
    print('The answer is: $_anwer');
  }

  /*int getTotalGuesses(){
    return _totalGuesses;
  }*/

  int get totalGuessses{
    return _totalGuesses;
  }



  int doGuess(int num){
    _totalGuesses++;

    if(num > _anwer){
      return 1;
    }else if (num < _anwer){
      return -1;
    }else{
      return 0;
    }
  }




}
