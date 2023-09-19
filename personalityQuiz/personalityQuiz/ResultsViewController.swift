//
//  ResultsViewController.swift
//  personalityQuiz
//
//  Created by Ethan Archibald on 9/18/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultsAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    
    var responses: [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not bee implemented")
    }
    
    func calculatePersonalityResult() {
        let frequencyOfAnswers = responses.reduce(into: [:]) {
            (counts, answer) in
                counts[answer.type, default: 0] += 1
        }
//        let  frequencyOfAnswers = responses.reduce(into: [AnimalType: Int]()) {
//            (counts, answer) in if let existingCount = counts[answer.type] {
//                counts[answer.type] = existingCount + 1
//            } else {
//                counts[answer.type] = 1
//            }
//        }
        
//        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {
//            (pair1, pair2) in
//                return pair1.value > pair2.value
//        })
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        resultsAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true)
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
