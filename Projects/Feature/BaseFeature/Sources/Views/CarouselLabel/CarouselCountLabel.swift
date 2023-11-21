import UIKit
import SnapKit
import Then
import DesignSystem
import UtilityModule

public class CarouselCountLabel: UIView {
    
    lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .setColor(.sub(.black)).withAlphaComponent(0.4)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    lazy var label: AlleyLabel = AlleyLabel()
    
    
    
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
            $0.height.equalTo(24)
            $0.center.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
            
        }
    }
    
    public func setCount(_ page: Int, _ total: Int) {
        label.setTitle(title: "\(page)/\(total)", textColor: .sub(.white), font: .caption1)
    }
}
