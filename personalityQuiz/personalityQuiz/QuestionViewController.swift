//
//  QuestionViewController.swift
//  personalityQuiz
//
//  Created by Ethan Archibald on 9/18/23.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [ Answer(text: "Steak", type: .dog), Answer(text: "Fish", type: .cat), Answer(text: "Carrots", type: .rabbit), Answer(text: "Corn", type: .turtle)]),
        
        Question(text: "Which activities do you enjoy?", type: .multiple, answers: [Answer(text: "Swimming", type: .turtle), Answer(text: "Sleeping", type: .cat), Answer(text: "Cuddling", type: .rabbit), Answer(text: "Eating", type: .dog)]),
        
        Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [Answer(text: "I Dislike them", type: .cat), Answer(text: "I get a little nervous", type: .rabbit), Answer(text: "I barely notice them", type: .turtle), Answer(text: "I love them", type: .dog)])
    ]
    
    var questionsIndex = 0
    var answersChosen: [Answer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = questions[questionsIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswer[0])
        case singleButton2:
            answersChosen.append(currentAnswer[1])
        case singleButton3:
            answersChosen.append(currentAnswer[2])
        case singleButton4:
            answersChosen.append(currentAnswer[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswer = questions[questionsIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswer[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswer[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswer[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswer[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswer = questions[questionsIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswer.count - 1)))
        
        answersChosen.append(currentAnswer[index])
        nextQuestion()
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    
    func nextQuestion() {
        questionsIndex += 1
        
        if questionsIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "results", sender: nil)
        }
    }
    
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionsIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionsIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionsIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
