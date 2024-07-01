//
//  ViewController.swift
//  URLSessionDelegate_Per
//
//  Created by 최승범 on 7/1/24.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let progressLabel = UILabel()
    private let downloadButton = UIButton()
    
    private var session: URLSession!
    private var total: Double = 0
    private var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    private func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(progressLabel)
        view.addSubview(downloadButton)
    }
    
    private func configureUI() {
        
        imageView.backgroundColor = .black
        progressLabel.backgroundColor = .blue
        downloadButton.backgroundColor = .green
        
        
        downloadButton.addTarget(self,
                                 action: #selector(downloadButtonClicked),
                                 for: .touchUpInside)
    }
    
    private func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
            make.width.equalTo(60)
        }
    }
    
    private func callRequest() {
        
        let request = URLRequest(url: Nasa.photo)
        
        session = URLSession(configuration: .default,
                             delegate: self,
                             delegateQueue: .main)
        session.dataTask(with: request).resume()
        
        
    }
    
    @objc private func downloadButtonClicked() {
        
        buffer = Data()
        callRequest()
    }
}

extension ViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode) {
            
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            
            total = Double(contentLength)!
            
            return .allow
        } else {
            return .cancel
        }
        
    }

    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        downloadButton.isEnabled = false
        if !downloadButton.isEnabled {
            downloadButton.backgroundColor = .red
        }
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: (any Error)?) {
        
        if let error = error {
            progressLabel.text = " 문제 "
            imageView.image = UIImage(systemName: "star.fill")
        } else {
            guard let buffer = buffer else {
                print("buffer nil")
                return
            }
            imageView.image = UIImage(data: buffer)
            
            downloadButton.isEnabled = true
            
            if downloadButton.isEnabled {
                downloadButton.backgroundColor = .blue
            }
        }
    }
}


enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}
