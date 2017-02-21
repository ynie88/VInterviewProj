//
//  S3Helper.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 2/7/17.
//  Copyright © 2017 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import AWSS3

class S3Helper {
    public static var sharedInstance = S3Helper()
    
    private let fileManager = FileManager()
    private let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    private let uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    private let uploadQueue = OperationQueue()
    private var fileSizeLimit:UInt64 {
        get {
            return 3*1024*1024
        }
    }
    
    private var accessKey:String {
        get {
            return "AKIAJJWN6NJOXYILRKYA"
        }
    }
    
    private var secretKey:String {
        get {
            return "zUHWmuFwTOAwyDwE7vqCLpERFAnvS9NJK2ZntJfN"
        }
    }
    
    private var S3BucketName:String {
        get {
            return "vignet-client-log"
        }
    }
    
    init() {
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let endpoint = AWSEndpoint(url: URL(string: "https://s3.amazonaws.com/\(S3BucketName)/"))
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, endpoint: endpoint!, credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }
    
    func writeToFile(text:String)
    {
        if VHFileWriter.sharedInstance.writeToFile(message: text, path: VHFileWriter.VHLogFilePath) {
            if getFileSize(with: VHFileWriter.VHLogFilePath) > fileSizeLimit {
                upload()
            }
        }
    }
    
    func download() {
        let downloadingFileURL = VHFileWriter.sharedInstance.getDocumentURL(path: "myImage.jpg")
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        downloadRequest?.bucket = S3BucketName
        downloadRequest?.key = "donut.jpg"
        downloadRequest?.downloadingFileURL = downloadingFileURL
        let transfermanager = AWSS3TransferManager.default()
        transfermanager.download(downloadRequest!).continueWith(executor: AWSExecutor.mainThread()) { (task) -> Any? in
            if let error = task.error as? NSError {
                if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                    switch code {
                    case .cancelled, .paused:
                        break
                    default:
                        print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                    }
                } else {
                    print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                }
                return nil
            }
            print("Download complete for: \(downloadRequest?.key)")
            let downloadOutput = task.result
            print("\(downloadOutput)")
            return nil
        }
        
    }
    
    func upload() {
        guard let filePath = VHFileWriter.sharedInstance.fileForUpload() else {
            print("file failed to upload")
            return
        }
        uploadQueue.addOperation { [weak self] in
            guard let _self = self, let fileURL = URL(string: filePath), let uploadRequest = _self.createUploadRequest(path: fileURL) else {return}
            
            let transferManager = AWSS3TransferManager.default()
            transferManager.upload(uploadRequest).continueWith(executor: AWSExecutor.mainThread(), block: { (task) -> Any? in
                if let _ = task.result {//task has completed and result was successful
                    VHFileWriter.sharedInstance.removeFile(fileName: filePath)
                } else if let error = task.error, let errorCode = AWSS3TransferManagerErrorType(rawValue: error._code) {
                    switch errorCode {
                    case .cancelled:
                        print("task cancelled")
                        break
                    case .paused:
                        print("task paused")
                        break
                    case .internalInConsistency:
                        print("task threw internal consistency")
                        break
                    case .invalidParameters:
                        print("invalid parameters")
                        break
                    case .unknown:
                        print("unknown error that was thrown")
                        break
                    default:
                        print("task...something else went wrong")
                    }
                }
                return nil
            })
        }
    }
    
    private func readFromFile(path:URL) {
        do {
            let file = try String(contentsOf: path, encoding: String.Encoding.utf8)
            print("reading from file: \(file) from path: \(path)")
            try fileManager.removeItem(at: path)
        } catch (let error) {
            print("error reading file: \(error)")
        }
    }
    
    private func createUploadRequest(path:URL) -> AWSS3TransferManagerUploadRequest? {
        let filePath = URL(fileURLWithPath: "\(path.path)")
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        var contentLength = NSNumber(integerLiteral: 0)
        if let attriOp = try? FileManager.default.attributesOfItem(atPath: filePath.path) {
            if let fileSize = attriOp[FileAttributeKey.size] as? Int {
                contentLength = NSNumber(integerLiteral: fileSize)
            }
        }
        

        uploadRequest?.body = filePath
        uploadRequest?.key = path.lastPathComponent
        uploadRequest?.bucket = S3BucketName
        uploadRequest?.contentLength = contentLength
        return uploadRequest
    }
    
    private func getFileSize(with path:String) -> UInt64{
        do {
            var documentPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
            documentPath.appendPathComponent(path)
            let attri = try FileManager.default.attributesOfItem(atPath: documentPath.path)
            
            if let fileSize = attri[FileAttributeKey.size] as? UInt64 {
                return fileSize
            } else {
                return 0
            }
        } catch {
            return 0
        }
    }
}

class VHFileWriter {
    public static let VHLogFilePath = "VHLogText.txt"
    
    static let sharedInstance = VHFileWriter()
    private let documentPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    private let defaultFileManager = FileManager.default
    
    /*Write to file will create a file at path if it doesn't exists and writes the message to that file*/
    func writeToFile(message:String, path:String) -> Bool{
        let documentURL = getDocumentURL(path: path)
        if !createFile(documentURL: documentURL) {
            print("failed to create document")
            return false
        }
        guard let data = message.data(using: .utf8) else {return false}
        do {
            let fileHandle = try FileHandle.init(forUpdating: documentURL)
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
            fileHandle.closeFile()
            return true
        } catch (let error){
            print("file handle failed to initalize with path \(documentURL), error\(error)")
            return false
        }
    }
    
    
    /*The following function will read out the file in the default text, generates a new file with the unique timestamp and device ID */
    func fileForUpload() -> String?{
        let documentURL = getDocumentURL(path: VHFileWriter.VHLogFilePath)
        if defaultFileManager.fileExists(atPath: documentURL.path) {//check if file exists first
            var deviceString  = UUID().uuidString
            if let vendorId = UIDevice.current.identifierForVendor?.uuidString {
                deviceString = vendorId
            }
            let uniqueUploadPath = "\(deviceString)_\(Date().timeIntervalSince1970).txt"
            let newPath = getDocumentURL(path: uniqueUploadPath)
            do {
                try defaultFileManager.moveItem(atPath: documentURL.path, toPath: newPath.path)
                return newPath.path
            } catch {
                print("failed to rename file")
                return nil
            }
            
        }
        return nil
    }
    
    func removeFile(fileName:String) {
        if defaultFileManager.fileExists(atPath: fileName) {
            guard let uniqueLogFile = URL(string: fileName) else {return}
            try? defaultFileManager.removeItem(at: uniqueLogFile)
        }
    }
    
    private func createFile(documentURL:URL) -> Bool{
        if !defaultFileManager.fileExists(atPath: documentURL.path) {
            do {
                try defaultFileManager.createDirectory(at: documentPath, withIntermediateDirectories: true, attributes: nil)
                defaultFileManager.createFile(atPath: documentURL.path, contents: nil, attributes: nil)
                return true
            } catch (let error) {
                print("file manager failed to create directory with error:\(error)")
                return false
            }
        } else {
            return true
        }
    }
    
    public func getDocumentURL(path: String) -> URL{
        let copyDocumentPath = documentPath
        let documentURL = copyDocumentPath.appendingPathComponent(path)
        return documentURL
    }
}
