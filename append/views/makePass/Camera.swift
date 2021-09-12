//
//    CameraViewController.swift
//    append
//
//    Created by Jimmy Kang on 9/11/21.
//

import Foundation
import UIKit
import AVFoundation

import UIKit
import Vision
import AVFoundation
import SafariServices

class Camera: UIViewController {
    // MARK: - Private Variables
    var captureSession = AVCaptureSession()

    // TODO: Make VNDetectBarcodesRequest variable
    lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
        guard error == nil else {
            self.showAlert(withTitle: "Barcode error", message: error?.localizedDescription ?? "error")
            return
        }
        self.processClassification(request)
    }

    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermissions()
        setupCameraLiveView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // TODO: Stop Session
        captureSession.stopRunning()
    }
    
    func handleObservedData(payload: String?, symbology: VNBarcodeSymbology) {
        // push next view
        if payload != nil {
            let configure = ConfigurePass()
            configure.codeData = payload!
            configure.codeSymbology = symbology
            self.present(configure, animated:true)
        } else {
            print("payload was nil. cannot do anything.")
        }
        
        
    }
}


extension Camera {
    // MARK: - Camera
    private func checkPermissions() {
        // TODO: Checking permissions
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [self] granted in
                if !granted {
                    self.showPermissionsAlert()
                }
            }
        case .denied, .restricted:
            showPermissionsAlert()
        default:
            return
        }
    }

    private func setupCameraLiveView() {
        // TODO: Setup captureSession
        captureSession.sessionPreset = .hd1280x720

        // TODO: Add input
        let videoDevice = AVCaptureDevice
            .default(.builtInWideAngleCamera, for: .video, position: .back)

        guard
            let device = videoDevice,
            let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
            captureSession.canAddInput(videoDeviceInput) else {
                showAlert(
                    withTitle: "Cannot Find Camera",
                    message: "There seems to be a problem with the camera on your device.")
                return
            }

        captureSession.addInput(videoDeviceInput)

        // TODO: Add output
        let captureOutput = AVCaptureVideoDataOutput()
        // TODO: Set video sample rate
        captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        captureSession.addOutput(captureOutput)

        configurePreviewLayer()

        // TODO: Run session
        captureSession.startRunning()
    }

    // MARK: - Vision
    func processClassification(_ request: VNRequest) {
        // TODO: Main logic
        guard let barcodes = request.results else { return }
        DispatchQueue.main.async { [self] in
            if captureSession.isRunning {
                view.layer.sublayers?.removeSubrange(1...)

                for barcode in barcodes {
                    guard
                        // TODO: Check for QR Code symbology and confidence score
                        let code = barcode as? VNBarcodeObservation,
                        code.confidence > 0.9
                        else { return }
                    print("-----------")
                    print("predicted text: " + code.payloadStringValue!)
                    print("predicted symbology: " + code.symbology.rawValue)

                    handleObservedData(payload: code.payloadStringValue, symbology: code.symbology)
                }
            }
        }
    }
}


extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // TODO: Live Vision
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let imageRequestHandler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .right)

        do {
            try imageRequestHandler.perform([detectBarcodeRequest])
        } catch {
            print(error)
        }
    }
}


// MARK: - Helper
extension Camera {
    private func configurePreviewLayer() {
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        cameraPreviewLayer.frame = view.frame
        view.layer.insertSublayer(cameraPreviewLayer, at: 0)
    }

    private func showAlert(withTitle title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }

    private func showPermissionsAlert() {
        showAlert(
            withTitle: "Camera Permissions",
            message: "Please open Settings and grant permission for this app to use your camera.")
    }
}


// MARK: - SafariViewControllerDelegate
extension Camera: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        captureSession.startRunning()
    }
}

