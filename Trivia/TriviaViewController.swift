import UIKit


struct TriviaQuestion {
    var question: String
    var answers: [String]
    var correctAnswerIndex: Int
}

class TriviaViewController: UIViewController {
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet var AnswerButtons: [UIButton]!
    
    var questions: [TriviaQuestion] = [
        TriviaQuestion(question: "What is the name of the cowboy from Toy Story?", answers: ["Buzz", "Woody", "Jessie", "Rex"], correctAnswerIndex: 1),
        TriviaQuestion(question: "What is Kanye West's debut album?", answers: ["Donda", "Graduation", "The College Dropout", "Late Registration"], correctAnswerIndex: 2),
        TriviaQuestion(question: "Who is the NBA's all-time scoring leader?", answers: ["Michael Jordan", "LeBron James", "Kareem Abdul-Jabbar", "Kobe Bryant"], correctAnswerIndex: 1)
    ]
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentQuestion()
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let correctAnswer = currentQuestion.answers[currentQuestion.correctAnswerIndex]
        let alertTitle: String
        
        if sender.titleLabel?.text == correctAnswer {
            alertTitle = "Correct!"
        } else {
            alertTitle = "Wrong!"
        }
        
        let alert = UIAlertController(title: alertTitle, message: "The answer is \(correctAnswer).", preferredStyle: .alert)
        let nextAction = UIAlertAction(title: "Next", style: .default) { [weak self] _ in self?.loadNextQuestion()}
        alert.addAction(nextAction)
        present(alert, animated: true)
    }
    
    func loadNextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            displayCurrentQuestion()
        } else {
            let alert = UIAlertController(title: "End of Quiz", message: "You have completed all questions.", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
                self?.currentQuestionIndex = 0
                self?.displayCurrentQuestion()
            }
            alert.addAction(restartAction)
            present(alert, animated: true)
        }
    }
    
    func displayCurrentQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        QuestionLabel.text = currentQuestion.question
        for (index, button) in AnswerButtons.enumerated() {
            button.setTitle(currentQuestion.answers[index], for: .normal)
        }
    }
}
