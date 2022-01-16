//
//  ViewController.swift
//  Apple Pie
//
//  Created by Евгений Пашко on 17.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var someImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowerd = 7
    var listOfWords = [
        "Акула",
        "Антилопа",
        "Бабочка",
        "Баран",
        "Барсук",
        "Белка",
        "Бобр",
        "Бегемот",
        "Бык",
        "Волк",
        "Воробей",
        "Ворон",
        "Горилла",
        "Гусеница",
        "Дрозд",
        "Дятел",
        "Жираф",
        "Змея",
        "Индюк",
        "Канарейка",
        "Кенгуру",
        "Козел",
        "Комар",
        "Корова",
        "Крокодил",
        "Кролик",
        "Кукушка",
        "Курица",
        "Лев",
        "Лисица",
        "Лось",
        "Лошадь",
        "Лягушка",
        "Медведь",
        "Муравей",
        "Мышь",
        "Олень",
        "Орел",
        "Оса",
        "Павлин",
        "Паук",
        "Петух",
        "Пингвин",
        "Попугай",
        "Пчела",
        "Рысь",
        "Синица",
        "Скорпион",
        "Слон",
        "Сова",
        "Таракан",
        "Тигр",
        "Тюлень",
        "Утка",
        "Фламинго",
        "Цапля",
        "Чайка",
        "Черепаха",
        "Ястреб",
        "Ящерица",
    ].shuffled()
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        
        let newWord = listOfWords.removeFirst()
        currentGame = Game (word: newWord, incorrectMovesRemaining: incorrectMovesAllowerd)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel() {
        var displayWord = [String]()
        for letter in currentGame.guessedWord{
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func updateUI() {
        let movesRemainig = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemainig + 64) % 8
        let image = "Tree \(imageNumber)"
        someImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), Проигрыши: \(totalLosses)"
    }
    
    // MARK: - IB Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled  = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
}

