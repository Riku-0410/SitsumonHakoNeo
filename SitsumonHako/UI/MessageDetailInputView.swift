//
//  MessageDetailInputView.swift
//  SitsumonHako
//
//  Created by Rikuya Shiraishi on 2021/09/07.
//



import SwiftUI

struct MessageDetailInputView: View {
    @Binding var text:String
    @State var textHeight: CGFloat = 0
    var textFieldHeight: CGFloat {
        let minHeight: CGFloat = 30
        let maxHeight: CGFloat = 70
        if textHeight < minHeight {
            return minHeight
        }
        
        if textHeight > maxHeight {
            return maxHeight
        }
        return textHeight
    }
    
    var action:() -> Void
    
    var body: some View {

            HStack{
                MessageDetailInputViewField(text: $text,height: $textHeight)
                    .cornerRadius(15)
                Button(action:action){
                    Text("送信")
                        .bold()
                        .foregroundColor(.blue)
                }
            }
            .frame(height: textFieldHeight)
            .padding(.vertical, 8)
            .padding(.horizontal)

    }
}

struct MessageDetailInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageDetailInputView(text: .constant(String("_tt")),textHeight: 30,action: {
            
        })
    }
}

struct MessageDetailInputViewField: UIViewRepresentable{
    @Binding var text: String
    @Binding var height: CGFloat
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
        textView.text = text
        context.coordinator.textView = textView
        textView.delegate = context.coordinator
        textView.layoutManager.delegate = context.coordinator
        textView.backgroundColor = UIColor.hex(string: "F6F6F6", alpha: 1)        //これがキーここで一定の高さ行ったらスクロールtrueにしてそうじゃない時はfalseにすればいい？
        return textView
    }
    func updateUIView(_ view: UITextView, context: Context){
        view.text = text
    }
    
    
}

extension MessageDetailInputViewField {
    class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate{
        
        let parent: MessageDetailInputViewField
        
        weak var textView: UITextView?
        
        init(parent: MessageDetailInputViewField){
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        func layoutManager(
            _ layoutManager: NSLayoutManager,
            didCompleteLayoutFor textContainer: NSTextContainer?,
            atEnd layoutFinishedFlag: Bool) {
            
            DispatchQueue.main.async { [weak self] in
                guard let view = self?.textView else {
                    return
                }
                let size = view.sizeThatFits(view.bounds.size)
                if self?.parent.height != size.height {
                    self?.parent.height = size.height
                }
            }
            
            

        }
    }
}

