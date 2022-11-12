//
//  OverviewController.swift
//  jboisjoli-babbel
//
//  Created by Jay Boisjoli on 2022-11-11.
//

import UIKit

protocol OverviewControllerProtocol: AnyObject {
    var presenter: OverviewPresenterProtocol? { get set }
    func updateSections(sections: [OverviewSection], reload: Bool)
    func correctIncrease()
    func incorrectIncrease()
}

class OverviewController: UIViewController {
    
    // HeaderView
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var correctAttemptsLabel: UILabel!
    @IBOutlet private weak var wrongAttemptsLabel: UILabel!
    
    // BottomView
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var correctCTA: UIButton!
    @IBOutlet private weak var wrongCTA: UIButton!
    
    @IBOutlet private weak var mainTableView: UITableView!
    
    var presenter: OverviewPresenterProtocol?
    private var sections: [OverviewSection] = []
    
    private var currentWord: WordPairUIModel?
    
    private var correctAttempts = 0
    private var wrongAttempts = 0
    private var currentIndex = 0
    
    // Timer
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareTableView()
        
        addNavigationItems()
        configureUI()
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewDidLoad()
        resetTimer()
    }
    
    @IBAction func correctAction(_ sender: Any) {
        guard let currentWord = self.currentWord else { return }
        self.presenter?.validateCorrect(word: currentWord)
    }
    
    @IBAction func wrongAction(_ sender: Any) {
        guard let currentWord = self.currentWord else { return }
        self.presenter?.validateIncorrect(word: currentWord)
    }
}

// MARK: - OverviewControllerProtocol
extension OverviewController: OverviewControllerProtocol {
    func updateSections(sections: [OverviewSection], reload: Bool) {
        self.sections = sections

        if reload {
            mainTableView.reloadData()
        }
    }
    
    func correctIncrease() {
        currentIndex+=1
        
        increaseCorrectAttempts()
        mainTableView.reloadData()
    }
    
    @objc func incorrectIncrease() {
        currentIndex+=1
        
        increaseWrongAttempts()
        
        resetTimer()
        mainTableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension OverviewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]

        switch section {
        case let .content(model):
            let cell = tableView.dequeueReusableCell(cellClass: MainTranslationCell.self)
            let currentWord = model[currentIndex]
            cell.set(data: currentWord)
            
            self.currentWord = currentWord
            
            // Close the app if wrong has reached to 3 or user reached 15 correct
            if wrongAttempts == 3 || correctAttempts == 15 {
                exit(0)
            }

            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]

        switch section {
        case .content:
            return 1
        }
    }
}

//MARK: - UITableViewDelegate
extension OverviewController: UITableViewDelegate {}

// MARK: - Private extension/methods
private extension OverviewController {
    func prepareTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.alwaysBounceVertical = false
        mainTableView.backgroundColor = .white
        
        mainTableView.register(cells: [MainTranslationCell.self])
    }
    
    func addNavigationItems() {
        self.title = Constants.babbelTitle
    }
    
    func configureUI() {
        view.backgroundColor = .white
        headerView.backgroundColor = .white
        bottomView.backgroundColor = .white
 
        correctCTA.tintColor = .babbelColor
        wrongCTA.tintColor = .black
    }
    
    func setTitle() {
        correctAttemptsLabel.text = "Correct attemps: \(correctAttempts)"
        wrongAttemptsLabel.text = "Wrong attemps: \(wrongAttempts)"
        
        correctCTA.setTitle("Correct", for: .normal)
        wrongCTA.setTitle("Wrong", for: .normal)
    }
    
    func increaseCorrectAttempts() {
        correctAttempts+=1
        correctAttemptsLabel.text = "Correct attemps: \(correctAttempts)"
    }
    
    func increaseWrongAttempts() {
        wrongAttempts+=1
        wrongAttemptsLabel.text = "Wrong attemps: \(wrongAttempts)"
    }
    
    @objc func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(incorrectIncrease), userInfo: nil, repeats: false)
    }
}
