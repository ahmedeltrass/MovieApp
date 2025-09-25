//
//  Video+Image.swift
//  Hagazt
//
//  Created by Ahmed_POMAC on 13/01/2025.
//

import AVFoundation
import UIKit

public func compressVideo(inputVideoData: Data, completion: @escaping (Data?) -> Void) {
    // Create a temporary file URL for the input video data
    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".mp4")
    
    do {
        // Write the input data to the temporary file
        try inputVideoData.write(to: tempURL)
        
        // Create AVAsset from the file URL
        let asset = AVAsset(url: tempURL)
        
        // Initialize AVAssetExportSession for compression
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality) else {
            print("Export session could not be created.")
            completion(nil)
            return
        }
        
        // Define the output URL for the compressed video
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + "_compressed.mp4")
        
        // Set up the export session
        exportSession.outputURL = outputURL
        exportSession.outputFileType = .mp4
        
        // Export asynchronously
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                do {
                    // Get the compressed video data
                    let compressedData = try Data(contentsOf: outputURL)
                    print("Successfully compressed video to size: \(compressedData.count) bytes")
                    completion(compressedData)
                } catch {
                    print("Error reading compressed video data: \(error)")
                    completion(nil)
                }
                
            case .failed:
                if let error = exportSession.error {
                    print("Compression failed with error: \(error)")
                }
                completion(nil)
                
            default:
                print("Compression in progress or unknown status")
                completion(nil)
            }
        }
        
    } catch {
        print("Error writing input data to temporary file: \(error)")
        completion(nil)
    }
}
public func resizeImage(_ image: UIImage, to targetSize: CGSize) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: targetSize)
    return renderer.image { _ in
        image.draw(in: CGRect(origin: .zero, size: targetSize))
    }
}
