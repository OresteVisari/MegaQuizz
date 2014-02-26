import 'dart:html';

DivElement content = querySelector('#sample_text_id');

void main() {
  displayMainMenu();
}

void displayMainMenu() {
  content.children.clear();
  
  ImageButtonInputElement button = new ImageButtonInputElement();
  button..id = 'quizz-logiciel-libre'
        ..src = "images/quizz/logiciel-libre.png"
        ..style.width = "120px"
        ..onClick.listen((e) => displayQuestions());
  
  content.children.add(button);
}

void displayQuestions() {
  content.children.clear();

  ParagraphElement question = new ParagraphElement();
  question..text = 'Qui est à l\'origine du projet GNU ?'
          ..style.marginTop = '-40px'
          ..style.fontSize = '14px';
  
  content.children.add(question);
     
  addAnswer('Tim Berners-Lee', false);
  addAnswer('Richard Matthew Stallman', true);
  addAnswer('Linus Torvalds', false);
  addAnswer('Dennis Ritchie', false);
}

void addAnswer(String text, bool value) {
  DivElement divAnswer = new DivElement();
  ButtonElement buttonAnswer = new ButtonElement();
  
  buttonAnswer..name = 'anser'
              ..text = text
              ..style.width = '200px'
              ..style.height = '50px'
              ..onClick.listen((e) => showResult(value));
  
  divAnswer.children.add(buttonAnswer);
  content.children.add(divAnswer);
}

void showResult(bool value) {
  if (value) {
    window.alert('Bravo !!!');
  } else {
    window.alert('Perdu :-(');
  }
  displayMainMenu();
}