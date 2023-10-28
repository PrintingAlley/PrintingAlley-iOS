//
//  ReviewViewController.swift
//  ReviewFeatureDemo
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import PhotosUI
import RxCocoa
import RxSwift
import Kingfisher

class ReviewViewController: UIViewController {

    lazy var button: UIButton = UIButton().then {
        $0.setTitle("ju", for: .normal)
        $0.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    lazy var runButton: UIButton = UIButton().then {
        $0.setTitle("GO", for: .normal)
    }
    
    lazy var imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var imageView2: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    
    let disposeBag = DisposeBag()
    var viewModel: ReviewViewModel!
    var input: ReviewViewModel.Input = ReviewViewModel.Input()
    
    
    init(viewModel: ReviewViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(button,imageView,runButton,imageView2)
        makeConstraints()
        bindViewModel()
        


    }
    
    
    @objc func tap() {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let library =  UIAlertAction(title: "앨범", style: .default) { _ in
                self.requestPhotoLibraryPermission()
            }
            let camera =  UIAlertAction(title: "카메라", style: .default) { _ in
                self.requestCameraPermission()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

            alert.addAction(library)
            alert.addAction(camera)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
    }
    
    
    func makeConstraints() {
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        runButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        imageView2.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.bottom.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: input)
        
        bindDataSource(output: output)
        
        runButton.rx.tap
            .bind(to: input.tapSend)
            .disposed(by: disposeBag)
        
        output.result
            .withUnretained(self)
            .subscribe(onNext: { (owner,data) in
                
                owner.imageView2.kf.setImage(with: URL(string: data))
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindDataSource(output: ReviewViewModel.Output) {
        
        output.dataSource
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (owner,data) in
                
                owner.imageView.image = UIImage(data: data)
                
                
            })
            .disposed(by: disposeBag)
           

    }

}


extension ReviewViewController: RequestPermissionable {
    func showCamera() {
        let camera = UIImagePickerController()
        camera.sourceType = .camera
        camera.allowsEditing = true
        camera.cameraDevice = .rear
        camera.cameraCaptureMode = .photo
        camera.delegate = self
        self.present(camera, animated: true, completion: nil)
    }
    
    func showPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    
}

extension ReviewViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
                   return
        }
    
        
        guard let imageToData = image.pngData() else { return }
        
        self.input.dataSource.onNext(imageToData)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ReviewViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        
        results.forEach{
            
            let provider = $0.itemProvider
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                
                provider.loadObject(ofClass: UIImage.self) {[weak self]  image, error in
                    
                    guard let self else {return}
                    
                    guard let image = image as? UIImage, let imageToData = image.pngData() else { return }
                    
                    input.dataSource.onNext(imageToData)
                    
                }
                
            }
            
        }
        
        
    }
    
    
}
