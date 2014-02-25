import 'dart:html';

void main() {
  displayMainMenu();
}

void displayMainMenu() {
  var content = querySelector('#sample_text_id');
  
  while (content.hasChildNodes()) {
    content.children.removeLast();
  }
  ImageButtonInputElement button = new ImageButtonInputElement();
  button..id = 'quizz-logiciel-libre'
        ..src = "images/quizz/logiciel-libre.png"
        ..style.width = "120px"
        ..onClick.listen((e) => displayQuestions());
  content.children.add(button);
}

void displayQuestions() {
  querySelector('#quizz-logiciel-libre').style.display = 'none';

  ParagraphElement question = new ParagraphElement();
  question..text = 'Qui est à l\'origine du projet GNU ?'
          ..style.marginTop = '-40px'
          ..style.fontSize = '14px';
  
  querySelector('#sample_text_id').children.add(question);
     
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
  
  querySelector('#sample_text_id').children.add(divAnswer);
}

void showResult(bool value) {
  if (value) {
    window.alert('Bravo !!!');
  } else {
    window.alert('Perdu :-(');
  }
  displayMainMenu();
}