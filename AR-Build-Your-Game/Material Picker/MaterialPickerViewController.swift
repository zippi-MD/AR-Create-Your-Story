//
//  MaterialPickerViewController.swift
//  AR-Build-Your-Game
//
//  Created by Alejandro Mendoza on 6/24/19.
//  Copyright © 2019 Alejandro Mendoza. All rights reserved.
//

import UIKit

class MaterialPickerViewController: UIViewController {

    private var picker: UIPickerView!
    private var selectorIndicatorView: UIView!
    private var suffixLabel: UILabel!
    
    var values: [Material]! {
        didSet{
            updatePickerData()
        }
    }
    
    var delegate: MaterialPickerDelegate?
    
    private let rotationAngle: CGFloat = 90 * (.pi/180)
    
    private let viewHeight = 150
    private let viewWidth = 250
    private let viewCornerRadius = CGFloat(10)
    
    private let pickerRowHeight = CGFloat(120)
    
    private let numberLabelWidth = 100
    private let numberLabelHeight = 100
    
    private let indicatorBorderWidth = CGFloat(5)
    
    private let viewBackgroundColor = UIColor.black.withAlphaComponent(0.3)
    private let textColor = UIColor.white
    
    private let numberTextFont = UIFont(name: "PingFangTC-Semibold", size: 40)
    private let textFont = UIFont(name: "PingFangTC-Semibold", size: 25)
    
    
    init(values: [Material]){
        self.values = values

        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = UIView(frame: CGRect(x: Int(-viewCornerRadius / 2), y: 0, width: viewWidth, height: viewHeight))
        self.view.backgroundColor = viewBackgroundColor
        view.layer.cornerRadius = viewCornerRadius
        
        setupPicker()
        setupSelectorIndicatorView()
        setupSuffixLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let row = 0
        picker.selectRow(row, inComponent: 0, animated: false)
        sendUpdatedValueToDelegate(value: values![row])
    }
    
    private func setupPicker(){
        picker = UIPickerView(frame: CGRect(x: 60, y: Int(-pickerRowHeight/2), width: viewHeight - 20, height: viewWidth))
        picker.dataSource = self
        picker.delegate = self
        
        picker.showsSelectionIndicator = false
        picker.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        self.view.addSubview(picker)
    }
    
    private func setupSuffixLabel(){
        let suffixLabelHeight = viewHeight/3
        suffixLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(pickerRowHeight), height: suffixLabelHeight))
        
        let pickerCenterInViewCoordinates = view.convert(picker.center, to: view)
        
        suffixLabel.center = CGPoint(x: pickerCenterInViewCoordinates.x, y: CGFloat(viewHeight - suffixLabelHeight/2 - Int(indicatorBorderWidth)))
        
        suffixLabel.text = values[0].name
        suffixLabel.textColor = textColor
        suffixLabel.font = textFont
        suffixLabel.textAlignment = .center
        
        view.insertSubview(suffixLabel, at: 0)
        
    }
    
    
    private func setupSelectorIndicatorView(){
        let indicatorWidth = pickerRowHeight + indicatorBorderWidth
        selectorIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: Int(indicatorWidth), height: viewHeight - Int(indicatorBorderWidth)))
        selectorIndicatorView.isUserInteractionEnabled = false
        selectorIndicatorView.center = CGPoint(x: picker.center.x, y: picker.center.y + indicatorBorderWidth*2)
        selectorIndicatorView.layer.borderWidth = indicatorBorderWidth
        selectorIndicatorView.layer.borderColor = textColor.cgColor
        selectorIndicatorView.layer.cornerRadius = 5
        
        view.addSubview(selectorIndicatorView)
        
    }
    
    override func didMove(toParent parent: UIViewController?) {
        guard let parent = parent else {return}
        
        let leftPadding = view.frame.width/2 + 40
        let bottomPadding = view.frame.height/2 + 20
        
        view.center = CGPoint(x: leftPadding, y: parent.view.frame.height - bottomPadding)
    }
    
    private func updatePickerData(){
        if let picker = picker{
            picker.reloadAllComponents()
        }
    }
    
    private func sendUpdatedValueToDelegate(value: Material){
        delegate?.pickerDidChangeValueTo(value)
    }
    
    //MARK: - Public Methods
    func getActualPickerValue() -> Material{
        return values[picker.selectedRow(inComponent: 0)]
    }
    
    
}

extension MaterialPickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    
}

extension MaterialPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        suffixLabel.text = values[row].name
        sendUpdatedValueToDelegate(value: values[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerRowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: numberLabelWidth, height: numberLabelHeight))
        imageView.image = values[row].image
        imageView.transform = CGAffineTransform(rotationAngle: -rotationAngle)
        
        return imageView
        
    }
    

}
