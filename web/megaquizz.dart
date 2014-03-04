import 'dart:html';
import 'dart:convert';

DivElement content = querySelector('#sample_container_id');
Element sub_title = querySelector('#sub_title');
int curentQuestion, score;
Map quizz;
List listOfQuizz = ["logiciel-libre", "litterature-classique", "cinema", "one-piece"];

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
  
  for (String id in listOfQuizz) {
    addQuizz(id);
  }
}

/**
 * Add a new quizz
 */
void addQuizz(String id) {
  ImageButtonInputElement button = new ImageButtonInputElement();
  button..classes.add("buttonQuizz")
        ..src = "images/quizz/$id.png"
        ..onClick.listen((e) => loadQuizz(id));
  
  content.children.add(button);
}

/**
 * Load the quizz, a json file...
 */
void loadQuizz(String id) {
  content.children.clear();  
  String path = "quizz/$id.json";
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
  Map question = quizz["questions"][curentQuestion];
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
  int bestScore = 0;
  int numberOfQuestions = quizz["questions"].length;
  String nameOfQuizz = quizz["name"];
  Storage localStorage = window.localStorage;

  if (localStorage[nameOfQuizz] != null) {
    bestScore = int.parse(localStorage[nameOfQuizz]);
  }

  if (score > bestScore) {
    localStorage[nameOfQuizz] = score.toString();
    bestScore = score;
  }

  ParagraphElement parScore = new ParagraphElement();
  ParagraphElement parBestScore = new ParagraphElement();
  parScore.text = "Votre score est de $score / $numberOfQuestions";
  parBestScore.text = "Votre record est de $bestScore /  $numberOfQuestions";
  content.children.add(parScore);
  content.children.add(parBestScore);
}