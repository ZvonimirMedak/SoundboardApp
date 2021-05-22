//
//  ___HEADERFILE___
//
import Foundation
import RxSwift
import RxCocoa
import AVKit

class HomeViewModel {
    public let personRelay = BehaviorRelay<[Person]>.init(value: [])
    public let userInteractionSubject = PublishSubject<Int>()
    public let loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    private var avPlayer = AVPlayer()
    
    public func bindViewModel() -> [Disposable] {
        var disposables = [Disposable]()
        disposables.append(initializeUserInteractionObservable(for: userInteractionSubject))
        disposables.append(initializeLoadDataObservable(for: loadDataSubject))
        return disposables
    }
}

private extension HomeViewModel {
    
    func initializeUserInteractionObservable(for subject: PublishSubject<Int>) -> Disposable {
        return subject
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .do(onNext: { [unowned self] (index) in
                handleSound(for: index)
            })
            .subscribe()
    }
    
    func handleSound(for index: Int) {
        avPlayer.pause()
        let path = Bundle.main.path(forResource: personRelay.value[index].soundURL, ofType: "mp3")
        let soundUrl = URL(fileURLWithPath: path!)
        let playerItem:AVPlayerItem = AVPlayerItem(url: soundUrl)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer.play()
    }
    
    func initializeLoadDataObservable(for subject: ReplaySubject<()>) -> Disposable {
        return subject
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .map{ [unowned self] _ -> [Person] in
                return createScreenData()
            }
            .subscribe(onNext: { [unowned self] (items) in
                personRelay.accept(items)
            })
    }
    
    func createScreenData() -> [Person] {
        return [Person(image: UIImage(named: "elon")!, soundURL: "elon"), Person(image: UIImage(named: "zukerberg")!, soundURL: "zukerberg"), Person(image: UIImage(named: "maminjo")!, soundURL: "mamic")]
    }
}
