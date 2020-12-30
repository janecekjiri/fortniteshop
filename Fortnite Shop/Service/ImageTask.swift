//
//  ImageTask.swift
//  Fortnite Shop
//
//  Created by Jiri Janecek on 30/12/2020.
//  Copyright © 2020 Jiri Janecek. All rights reserved.
//

import UIKit

class ImageTask {

    private let url: String
    private let session: URLSession

    private(set) var image: UIImage?
    var didDownloadImage: (() -> Void)?

    private var task: URLSessionDownloadTask?
    private var resumeData: Data?

    private var isDownloading = false
    private var isFinishedDownloading = false

    init(url: String, session: URLSession) {
        self.url = url
        self.session = session
    }

    func resume() {
        if !isDownloading && !isFinishedDownloading {
            isDownloading = true

            if let resumeData = resumeData {
                task = session.downloadTask(
                    withResumeData: resumeData,
                    completionHandler: downloadTaskCompletionHandler
                )
            } else {
                if let url = URL(string: url) {
                    task = session.downloadTask(with: url, completionHandler: downloadTaskCompletionHandler)
                }
            }

            task?.resume()
        }
    }

    func pause() {
        if isDownloading && !isFinishedDownloading {
            task?.cancel(byProducingResumeData: { (data) in
                self.resumeData = data
            })

            self.isDownloading = false
        }
    }

    private func downloadTaskCompletionHandler(url: URL?, response: URLResponse?, error: Error?) {
        if let error = error {
            print("Error downloading: ", error)
            return
        }

        guard let url = url else { return }
        guard let data = FileManager.default.contents(atPath: url.path) else { return }
        guard let image = UIImage(data: data) else { return }

        DispatchQueue.main.async {
            self.image = image
            self.didDownloadImage?()
        }

        self.isFinishedDownloading = true
    }
}
