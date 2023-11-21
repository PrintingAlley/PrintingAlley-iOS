import UIKit
import SnapKit
import Then
import DesignSystem
import UtilityModule

public class CarouselCountLabel: UIView {
    
    lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100)).withAlphaComponent(0.4)
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
    }
    lazy var label: AlleyLabel = AlleyLabel("\(1)/\(10)", textColor: .sub(.white), font: .caption1)
    
    
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarouselCountLabel {
    
    func addSubviews() {
        self.addSubviews(containerView)
        self.containerView.addSubviews(label)
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints {
            $0.height.equalTo(26)
            $0.center.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(11)
            
        }
    }
    
    public func setCount(_ page: Int, _ total: Int) {
        label.setTitle(title: "\(page)/\(total)", textColor: .sub(.white), font: .caption1)
    }
}
