import 'dart:html';
import 'dart:convert';

DivElement content = querySelector('#sample_container_id');
Element sub_title = querySelector('#sub_title');
int curentQuestion, score;
Map quizz;

void main() {
  querySelector('#title').onClick.listen((e) => displayMainMenu());
  displayMainMenu();
}

/**
 * Display the main menu
 */
void displayMainMenu() {
  content.children.clear();
  score = curentQuestion = 0;
  sub_title.text = "Pour apprendre tout en jouant";
  
  ImageButtonInputElement button = new ImageButtonInputElement();
  button..id = 'quizz-logiciel-libre'
        ..src = "images/quizz/logiciel-libre.png"
        ..style.width = "120px"
        ..onClick.listen((e) => loadQuizz());
  
  content.children.add(button);
}

/**
 * Load the quizz, a json file...
 */
void loadQuizz() {
  content.children.clear();  
  String path = "logiciel-libre.json";
  HttpRequest.getString(path).then(displayQuizz);
}

/**
 * and parse this to a Map
 */
void displayQuizz(String file) {
  quizz = JSON.decode(file);
  sub_title.text = quizz["description"];
  displayQuestion();
}

/**
 * Display the curent question
 */
void displayQuestion() {
  content.children.clear();
  var question = quizz["questions"][curentQuestion];
  ParagraphElement parQuestion = new ParagraphElement();
  parQuestion.text = question["question"];
  content.children.add(parQuestion);

  List answers = question["answers"];
  int solution = int.parse(question["solution"]) - 1;
  for (var i = 0; i < answers.length; i++) {
    if (i == solution) {
      addAnswer(answers[i], true);
    } else {
      addAnswer(answers[i], false);
    }
  }
  curentQuestion++;
}

/**
 * Add the answer
 */
void addAnswer(String text, bool value) {
  DivElement divAnswer = new DivElement();
  ButtonElement buttonAnswer = new ButtonElement();
  
  buttonAnswer..text = text
              ..onClick.listen((e) => nextQuestion(value));
  
  divAnswer.children.add(buttonAnswer);
  content.children.add(divAnswer);
}

/**
 * Increase score ansd show result if finish
 */
void nextQuestion(res){
  if (res) {
    score++;
  }
  
  if (curentQuestion < quizz["questions"].length) {
    displayQuestion();
  } else {
    showResult();
  }
}

/**
 * Show the result
 */
void showResult() {
  content.children.clear();
  ParagraphElement par = new ParagraphElement();
  int numberOfQuestions = quizz["questions"].length;
  par.text = "Votre score est de : $score / $numberOfQuestions ";
  content.children.add(par);
}