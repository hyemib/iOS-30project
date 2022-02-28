
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var mainTimerLabel: UILabel!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var startStopBtn: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    private var mainStopwatch = Stopwatch()
    private var lapStopwatch = Stopwatch()
    private var laps = [String]()
    private var isPlay = false
    private let timeInterval = 0.035
    private let minute = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
    }
    
    @IBAction func startStopTimer(_ sender: Any) {
        if isPlay {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
    
            changeBtn(button: startStopBtn, title: "Start", titleColor: .systemGreen)
            changeBtn(button: lapResetBtn, title: "Reset", titleColor: .black)
        } else {
            lapResetBtn.isEnabled = true
            
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            changeBtn(button: startStopBtn, title: "Stop", titleColor: .systemRed)
            changeBtn(button: lapResetBtn, title: "Lap", titleColor: .black)
        }
        isPlay = !isPlay
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: mainTimerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    private func updateTimer(_ stopwatch: Stopwatch, label: UILabel ) {
        stopwatch.counter = stopwatch.counter + timeInterval
        
        var minutes = "\(Int(stopwatch.counter) / minute)"
        
        if Int(stopwatch.counter) / minute < 10 {
            minutes = "0" + minutes
        }
        
        var seconds = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: Double(minute))))
        
        if stopwatch.counter.truncatingRemainder(dividingBy: Double(minute)) < 10 {
            seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }
    
    @IBAction func lapResetTimer(_ sender: Any) {
        if isPlay {
            if let timerLabel = mainTimerLabel.text {
                laps.append(timerLabel)
            }
            resetLapTimer()
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(updateLapTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            lapsTableView.reloadData()
        } else {
            resetMainTimer()
            resetLapTimer()
            lapResetBtn.isEnabled = false
            changeBtn(button: startStopBtn, title: "Start", titleColor: .systemGreen)
            changeBtn(button: lapResetBtn, title: "Lap", titleColor: .black)
            
        }
    }
    
    private func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00.00"
    }
    
    private func resetMainTimer() {
        resetTimer(mainStopwatch, label: mainTimerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    private func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    private func changeBtn(button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapsCell", for: indexPath)
        if let labelNum = cell.viewWithTag(11) as? UILabel {
            labelNum.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
        }
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
        
        return cell
    }
    
    
}
