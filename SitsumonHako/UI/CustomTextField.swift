//
//  CustomTextField.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/04.
//

import SwiftUI


struct CustomTextFieldView: View {
    @Binding var text:String
    @State var isEditing:Bool = false
    var title:String
    var caution:String?
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text(title)
                    .foregroundColor(isEditing ? Color.blue : Color.gray)
                    .font(.caption)
                    .fontWeight(.medium)
                Spacer()
                Text(caution ??  "")
                    .foregroundColor(Color(hex: "E2785A"))
                    .font(.caption2)
            }
            CustomTextField(text: $text ,isEditing: $isEditing)
                .background(Color.white)
                .padding(.top, 20)
            HorizontalLineView(color: isEditing ? Color.blue : Color.gray)
        }
    }
}


struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    func makeCoordinator() -> Coordinator {
         return Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ view: UITextField, context: Context) {
        view.text = self.$text.wrappedValue
    }
    


}

extension CustomTextField {
    class Coordinator: NSObject, UITextFieldDelegate{
        let parent: CustomTextField
        
        init(parent: CustomTextField){
            self.parent = parent
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.parent.isEditing = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            self.parent.isEditing = false
            self.parent.text = textField.text ?? ""
        }
    }
}


struct HorizontalLineShape: Shape {

    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))

        return path
    }
}

struct HorizontalLineView: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}


