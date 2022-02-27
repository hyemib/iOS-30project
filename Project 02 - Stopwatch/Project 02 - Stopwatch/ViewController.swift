
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var mainTimerLabel: UILabel!
    @IBOutlet weak var lapResetBtn: UIButton!
    @IBOutlet weak var startStopBtn: UIButton!
    
    private var mainStopwatch = Stopwatch()
    private var lapStopwatch = Stopwatch()
    private var isPlay = false
    private let timeInterval = 0.035
    private let minute = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startStopTimer(_ sender: Any) {
        if isPlay {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            
            changeBtn(button: startStopBtn, title: "Start", titleColor: .systemGreen)
            changeBtn(button: lapResetBtn, title: "Reset", titleColor: .black)
        } else {
            
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
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel ) {
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
            
        } else {
            changeBtn(button: startStopBtn, title: "Start", titleColor: .systemGreen)
            changeBtn(button: lapResetBtn, title: "Lap", titleColor: .black)
            
        }
    }
    
    func changeBtn(button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
    }
    
}

