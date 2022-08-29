//
//  MoviePlayerViewController.swift
//  LookOffices
//
//  Created by samet ogutcuoglu on 24.08.2022.
//

import UIKit
import AVFoundation
import AVKit

protocol MoviePlayerDisplayLogic: AnyObject {
    
}

final class MoviePlayerViewController: UIViewController {
    
    var interactor: MoviePlayerBusinessLogic?
    var router: (MoviePlayerRoutingLogic & MoviePlayerDataPassing)?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var fullScreenButton: UIButton!
    @IBOutlet weak var videoPosterImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var videoVolumeButton: UIButton!
    @IBOutlet weak var videoTotalTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var PlayPauseButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var videoPlayerView: UIView!
    
    private var asset: AVAsset!
    private var playerItem: AVPlayerItem!
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private let seekDuration: Float64 = 3
    private let kTimescale: CMTimeScale = 1
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        videoPosterImageView.isHidden = true
        videoPlayerView.isHidden = true
        loadVideo()
        addPeriodicTimeObserver()
    }
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            generateThumbnailImage()
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute, .second]
            guard let videoTotalSeconds = asset?.duration.seconds else { return }
            let videoTotalMinutes = String(format: "%02d", Int(videoTotalSeconds) / 60)
            guard let formatVideoTotalSecond = formatter.string(from: TimeInterval((videoTotalSeconds))) else {return}
            videoTotalTimeLabel.text = "\(videoTotalMinutes):" + formatVideoTotalSecond
        }
    }
    
    func loadVideo () {
        guard let url = URL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v") else { return }
        asset = AVAsset(url: url)
        configurePlayer(asset: asset)
        updateSlider(to: 0)
    }
    
    func configurePlayer (asset: AVAsset) {
        playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        videoPlayerView.layer.addSublayer(playerLayer)
        player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoPlayerView.bounds
    }
    
    func updateSlider (to newValue : Float) {
        timeSlider.value = newValue
    }
    
    func addPeriodicTimeObserver() {
        
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1, preferredTimescale: timeScale)
        player.addPeriodicTimeObserver(forInterval: time,
                                                          queue: .main) { [weak self] time in

            guard let videoTotalSeconds = self?.asset.duration.seconds else { return }
            let videoNowMinutes = String(format: "%02d", Int(videoTotalSeconds) / 60)
            let videoNowSecond = String(format: "%02d", Int(time.seconds) % 60)

            self?.timeLabel.text = "\(videoNowMinutes):" + videoNowSecond
            
            if time.seconds >= videoTotalSeconds {
                self?.stopVideo()
            }
            self?.updateSlider(to: Float(time.seconds / videoTotalSeconds))
        }
    }
    
    func generateThumbnailImage() {
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        do {
            let time = CMTimeMake(value: Int64(5 * Double(kTimescale)), timescale: kTimescale)
            let cgImage = try assetGenerator.copyCGImage(at: time, actualTime: nil)
            videoPosterImageView.image = UIImage(cgImage: cgImage)
            videoPosterImageView.isHidden = false
            videoPosterImageView.bringSubviewToFront(videoVolumeButton)
            
            activityIndicatorView.isHidden = true
            activityIndicatorView.stopAnimating()
        } catch (let err) {
            print(err.localizedDescription)
        }
    }

    
    private func stopVideo() {
        PlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        player.seek(to: CMTime(value: 0, timescale: kTimescale))
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MoviePlayerInteractor()
        let presenter = MoviePlayerPresenter()
        let router = MoviePlayerRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func play() {
        player.play()
        videoPlayerView.isHidden = false
        videoPosterImageView.isHidden = true
        PlayPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    private func pause() {
        player.pause()
        PlayPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func playPauseVideo() {
        switch player.timeControlStatus {
        case .paused:
            play()
        case .playing:
           pause()
        default:
            break
        }
    }
    
    @IBAction func clickPlayPauseButton(_ sender: UIButton) {
        playPauseVideo()
    }
    
    @IBAction func clickSoundOffButton( sender: Any) {
        switch player.isMuted {
        case true:
            videoVolumeButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
            player.isMuted = false
        case false:
            videoVolumeButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
            player.isMuted = true
        }
    }
    
    @IBAction func clickShutDownButton( sender: Any) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        dismiss(animated: true)
    }
    
    @IBAction func clickFullScreenButton( sender: Any) {
        
        switch playerLayer.videoGravity {
        case .resize:
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            playerLayer.videoGravity = .resizeAspect
        case .resizeAspect:
            videoPlayerView.bringSubviewToFront(videoVolumeButton)
            videoPlayerView.bringSubviewToFront(fullScreenButton)
            videoPlayerView.bringSubviewToFront(closeButton)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            playerLayer.videoGravity = .resize
        default:
            playerLayer.videoGravity = .resizeAspect
        }
    }
    
    @IBAction func clickForwordButton( sender: Any) {
        guard let duration  = player.currentItem?.duration else{
            return
        }
        
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = playerCurrentTime + seekDuration
        
        if newTime < CMTimeGetSeconds(duration) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * Double(kTimescale)), timescale: kTimescale)
            player.seek(to: time2)
        }
    }
    
    @IBAction func clickBackwordButton( sender: Any) {
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = playerCurrentTime - seekDuration

        if newTime < 0 {
            newTime = 0
        }
        
        let time2: CMTime = CMTimeMake(value: Int64(newTime * Double(kTimescale)), timescale: kTimescale)
        player.seek(to: time2)
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let videoTotalSeconds = self.asset.duration.seconds
        let timeToSeek = videoTotalSeconds * Double(sender.value)
        player.seek(to: CMTimeMake(value: Int64(timeToSeek * Double(kTimescale)), timescale: kTimescale))
    }
}

extension MoviePlayerViewController: MoviePlayerDisplayLogic {
    
}
