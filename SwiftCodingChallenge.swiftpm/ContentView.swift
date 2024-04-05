import SwiftUI
import AVFoundation

// Model representing a language learning session
struct LanguageSession {
    let word: String
    let translation: String
    let pronunciation: String // Add pronunciation property
}

// Main view displaying the language learning game
struct ContentView: View {
    @State private var selectedLanguageIndex = 0
    @State private var isLanguageSelected = false
    @State private var currentSessionIndex = 0
    @State private var isLearningMode = true
    @State private var showAlert = false
    @State private var isCorrect = false
    @State private var showScore = false
    @State private var totalScore = 0
    
    let languages = ["Tamil", "Malayalam", "Kannada", "Urdu", "Bengali", "Hindi", "Punjabi", "Marathi", "Gujarati", "Telugu"]
    
    let tamilSessions: [LanguageSession] = [
        LanguageSession(word: "ஆப்பிள்", translation: "Apple", pronunciation: "ஆப்பிள்"),
        LanguageSession(word: "நாய்", translation: "Dog", pronunciation: "நாய்"),
        LanguageSession(word: "வணக்கம்", translation: "Hello", pronunciation: "வணக்கம்"),
        LanguageSession(word: "சித்தி", translation: "Mother's Sister", pronunciation: "சித்தி"),
        LanguageSession(word: "மாமா", translation: "Uncle", pronunciation: "மாமா"),
        LanguageSession(word: "அத்தை", translation: "Aunt", pronunciation: "அத்தை"),
        LanguageSession(word: "மூத்த சகோதரி", translation: "Elder Sister", pronunciation: "மூத்த சகோதரி"),
        LanguageSession(word: "போ", translation: "Go", pronunciation: "போ"),
        LanguageSession(word: "வாருங்கள்", translation: "Come", pronunciation: "வாருங்கள்"),
        LanguageSession(word: "இன்று", translation: "Today", pronunciation: "இன்று"),
    ]
    
    let malayalamSessions: [LanguageSession] = [
        LanguageSession(word: "ആപ്പിൾ", translation: "Apple", pronunciation: "ആപ്പിൾ"),
        LanguageSession(word: "നായ", translation: "Dog", pronunciation: "നായ"),
        LanguageSession(word: "ഹലോ", translation: "Hello", pronunciation: "ഹലോ"),
        LanguageSession(word: "നന്ദി", translation: "Thank You", pronunciation: "നന്ദി"),
        LanguageSession(word: "ശുഭ രാത്രി", translation: "Good Night", pronunciation: "ശുഭ രാത്രി"),
        LanguageSession(word: "സുഖമാണോ?", translation: "How Are You?", pronunciation: "സുഖമാണോ?"),
        LanguageSession(word: "മഴ", translation: "Rain", pronunciation: "മഴ"),
        LanguageSession(word: "പറവ", translation: "Bird", pronunciation: "പറവ"),
        LanguageSession(word: "പാല്", translation: "Milk", pronunciation: "പാല്"),
        LanguageSession(word: "അമ്പിളികൾ", translation: "Mangoes", pronunciation: "അമ്പിളികൾ"),
    ]
    
    let kannadaSessions: [LanguageSession] = [
        LanguageSession(word: "ಆಪಲ್", translation: "Apple", pronunciation: "ಆಪಲ್"),
        LanguageSession(word: "ನಾಯಿ", translation: "Dog", pronunciation: "ನಾಯಿ"),
        LanguageSession(word: "ಹಲೋ", translation: "Hello", pronunciation: "ಹಲೋ"),
        LanguageSession(word: "ಕುರಿ", translation: "Sheep", pronunciation: "ಕುರಿ"),
        LanguageSession(word: "ಅಮೃತ", translation: "Nectar", pronunciation: "ಅಮೃತ"),
        LanguageSession(word: "ಸಂತೆ", translation: "Road", pronunciation: "ಸಂತೆ"),
        LanguageSession(word: "ಬೆಳ್ಳಿ", translation: "Silver", pronunciation: "ಬೆಳ್ಳಿ"),
        LanguageSession(word: "ಬಿಳಿ", translation: "White", pronunciation: "ಬಿಳಿ"),
        LanguageSession(word: "ಹಣ್ಣು", translation: "Fruit", pronunciation: "ಹಣ್ಣು"),
        LanguageSession(word: "ತಾಯಿ", translation: "Mother", pronunciation: "ತಾಯಿ"),
    ]
    
    let urduSessions: [LanguageSession] = [
        LanguageSession(word: "سیب", translation: "Apple", pronunciation: "سیب"),
        LanguageSession(word: "کتا", translation: "Dog", pronunciation: "کتا"),
        LanguageSession(word: "سلام", translation: "Hello", pronunciation: "سلام"),
        LanguageSession(word: "شکریہ", translation: "Thank You", pronunciation: "شکریہ"),
        LanguageSession(word: "خدا حافظ", translation: "Goodbye", pronunciation: "خدا حافظ"),
        LanguageSession(word: "آپ کیسے ہیں؟", translation: "How Are You?", pronunciation: "آپ کیسے ہیں؟"),
        LanguageSession(word: "بارش", translation: "Rain", pronunciation: "بارش"),
        LanguageSession(word: "پرندہ", translation: "Bird", pronunciation: "پرندہ"),
        LanguageSession(word: "دودھ", translation: "Milk", pronunciation: "دودھ"),
        LanguageSession(word: "آم", translation: "Mango", pronunciation: "آم"),
    ]
    
    let bengaliSessions: [LanguageSession] = [
        LanguageSession(word: "আপেল", translation: "Apple", pronunciation: "আপেল"),
        LanguageSession(word: "কুকুর", translation: "Dog", pronunciation: "কুকুর"),
        LanguageSession(word: "হ্যালো", translation: "Hello", pronunciation: "হ্যালো"),
        LanguageSession(word: "ধন্যবাদ", translation: "Thank You", pronunciation: "ধন্যবাদ"),
        LanguageSession(word: "আম", translation: "Mango", pronunciation: "আম"),
        LanguageSession(word: "বৃষ্টি", translation: "Rain", pronunciation: "বৃষ্টি"),
        LanguageSession(word: "পাখি", translation: "Bird", pronunciation: "পাখি"),
        LanguageSession(word: "দুধ", translation: "Milk", pronunciation: "দুধ"),
        LanguageSession(word: "বাঘ", translation: "Tiger", pronunciation: "বাঘ"),
        LanguageSession(word: "সূর্য", translation: "Sun", pronunciation: "সূর্য"),
    ]
    
    let hindiSessions: [LanguageSession] = [
        LanguageSession(word: "सेब", translation: "Apple", pronunciation: "सेब"),
        LanguageSession(word: "कुत्ता", translation: "Dog", pronunciation: "कुत्ता"),
        LanguageSession(word: "नमस्ते", translation: "Hello", pronunciation: "नमस्ते"),
        LanguageSession(word: "धन्यवाद", translation: "Thank You", pronunciation: "धन्यवाद"),
        LanguageSession(word: "आम", translation: "Mango", pronunciation: "आम"),
        LanguageSession(word: "बारिश", translation: "Rain", pronunciation: "बारिश"),
        LanguageSession(word: "पक्षी", translation: "Bird", pronunciation: "पक्षी"),
        LanguageSession(word: "दूध", translation: "Milk", pronunciation: "दूध"),
        LanguageSession(word: "बाघ", translation: "Tiger", pronunciation: "बाघ"),
        LanguageSession(word: "सूरज", translation: "Sun", pronunciation: "सूरज"),
    ]
    
    let punjabiSessions: [LanguageSession] = [
        LanguageSession(word: "ਸੇਬ", translation: "Apple", pronunciation: "ਸੇਬ"),
        LanguageSession(word: "ਕੁੱਤਾ", translation: "Dog", pronunciation: "ਕੁੱਤਾ"),
        LanguageSession(word: "ਸਤ ਸ੍ਰੀ ਅਕਾਲ", translation: "Hello (Greeting)", pronunciation: "ਸਤ ਸ੍ਰੀ ਅਕਾਲ"),
        LanguageSession(word: "ਧੰਨਵਾਦ", translation: "Thank You", pronunciation: "ਧੰਨਵਾਦ"),
        LanguageSession(word: "ਆਮ", translation: "Mango", pronunciation: "ਆਮ"),
        LanguageSession(word: "ਬਾਰਿਸ਼", translation: "Rain", pronunciation: "ਬਾਰਿਸ਼"),
        LanguageSession(word: "ਪੰਛੀ", translation: "Bird", pronunciation: "ਪੰਛੀ"),
        LanguageSession(word: "ਦੁੱਧ", translation: "Milk", pronunciation: "ਦੁੱਧ"),
        LanguageSession(word: "ਬਘ", translation: "Tiger", pronunciation: "ਬਘ"),
        LanguageSession(word: "ਸੂਰਜ", translation: "Sun", pronunciation: "ਸੂਰਜ"),
    ]
    
    let marathiSessions: [LanguageSession] = [
        LanguageSession(word: "सफरचंद", translation: "Apple", pronunciation: "सफरचंद"),
        LanguageSession(word: "कुत्रा", translation: "Dog", pronunciation: "कुत्रा"),
        LanguageSession(word: "नमस्ते", translation: "Hello", pronunciation: "नमस्ते"),
        LanguageSession(word: "धन्यवाद", translation: "Thank You", pronunciation: "धन्यवाद"),
        LanguageSession(word: "आंबा", translation: "Mango", pronunciation: "आंबा"),
        LanguageSession(word: "पाऊस", translation: "Rain", pronunciation: "पाऊस"),
        LanguageSession(word: "पक्षी", translation: "Bird", pronunciation: "पक्षी"),
        LanguageSession(word: "दूध", translation: "Milk", pronunciation: "दूध"),
        LanguageSession(word: "वाघ", translation: "Tiger", pronunciation: "वाघ"),
        LanguageSession(word: "सूर्य", translation: "Sun", pronunciation: "सूर्य"),
    ]
    
    let gujaratiSessions: [LanguageSession] = [
        LanguageSession(word: "સફરજન", translation: "Apple", pronunciation: "સફરજન"),
        LanguageSession(word: "કૂતરો", translation: "Dog", pronunciation: "કૂતરો"),
        LanguageSession(word: "નમસ્તે", translation: "Hello", pronunciation: "નમસ્તે"),
        LanguageSession(word: "આભાર", translation: "Thank You", pronunciation: "આભાર"),
        LanguageSession(word: "કેરી", translation: "Mango", pronunciation: "કેરી"),
        LanguageSession(word: "વરસાદ", translation: "Rain", pronunciation: "વરસાદ"),
        LanguageSession(word: "પક્ષી", translation: "Bird", pronunciation: "પક્ષી"),
        LanguageSession(word: "દૂધ", translation: "Milk", pronunciation: "દૂધ"),
        LanguageSession(word: "વાઘ", translation: "Tiger", pronunciation: "વાઘ"),
        LanguageSession(word: "સૂર્ય", translation: "Sun", pronunciation: "સૂર્ય"),
    ]
    
    let teluguSessions: [LanguageSession] = [
        LanguageSession(word: "ఆపిల్", translation: "Apple", pronunciation: "ఆపిల్"),
        LanguageSession(word: "కుక్క", translation: "Dog", pronunciation: "కుక్క"),
        LanguageSession(word: "హలో", translation: "Hello", pronunciation: "హలో"),
        LanguageSession(word: "ధన్యవాదము", translation: "Thank You", pronunciation: "ధన్యవాదము"),
        LanguageSession(word: "మామిడి", translation: "Mango", pronunciation: "మామిడి"),
        LanguageSession(word: "వర్షం", translation: "Rain", pronunciation: "వర్షం"),
        LanguageSession(word: "పక్షి", translation: "Bird", pronunciation: "పక్షి"),
        LanguageSession(word: "పాలు", translation: "Milk", pronunciation: "పాలు"),
        LanguageSession(word: "పులి", translation: "Tiger", pronunciation: "పులి"),
        LanguageSession(word: "సూర్యుడు", translation: "Sun", pronunciation: "సూర్యుడు"),
    ]
    
    






    
    // Add sessions for Bengali, Hindi, Punjabi, Marathi, Gujarati, and Telugu similarly
    
    var currentSessions: [LanguageSession] {
        switch selectedLanguageIndex {
        case 0:
            return tamilSessions
        case 1:
            return malayalamSessions
        case 2:
            return kannadaSessions
        case 3:
            return urduSessions
        case 4:
            return bengaliSessions
        case 5:
            return hindiSessions
        case 6:
            return punjabiSessions
        case 7:
            return marathiSessions
        case 8:
            return gujaratiSessions
        case 9:
            return teluguSessions
        default:
            return tamilSessions
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer() // Pushes content to the middle of the screen
                
                if !isLanguageSelected {
                    Text("Choose the language you want to learn:")
                        .font(.headline)
                        .padding()
                    
                    // Display languages in three columns
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<languages.count, id: \.self) { index in
                            Button(action: {
                                self.selectedLanguageIndex = index
                                self.isLanguageSelected = true
                            }) {
                                Text(self.languages[index])
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                } else if isLearningMode {
                    VStack {
                        Text("Learn the words:")
                            .font(.headline)
                            .padding()
                        
                        ForEach(currentSessions, id: \.word) { session in
                            HStack {
                                Text(session.word)
                                Spacer()
                                Text(session.translation)
                                Spacer()
                                Button(action: {
                                    self.speak(word: session.pronunciation)
                                }) {
                                    Image(systemName: "speaker.wave.2.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                        }
                        
                        Button(action: {
                            self.isLearningMode = false
                        }) {
                            Text("Take Test")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                } else {
                    if !showScore {
                        VStack {
                            Text("Translate:")
                                .font(.headline)
                                .padding()
                            
                            Text(currentSessions[currentSessionIndex].word)
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            
                            TextField("Enter Translation", text: $input)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            Button(action: checkTranslation) {
                                Text("Check")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                            .padding()
                            
                            Text("Score: \(totalScore)")
                                .font(.headline)
                                .padding()
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(isCorrect ? "Correct!" : "Incorrect!"),
                                message: Text(isCorrect ? "Great job! You earned a point." : "Try again!"),
                                dismissButton: .default(Text("Next"), action: nextSession)
                            )
                        }
                    } else {
                        VStack {
                            Text("Test Completed!")
                                .font(.title)
                                .padding()
                            
                            Text("Your Score: \(totalScore)")
                                .font(.headline)
                                .padding()
                            
                            HStack {
                                Button(action: {
                                    self.isLearningMode = true
                                    self.showScore = false
                                    self.totalScore = 0
                                }) {
                                    Text("Learn Again")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.green)
                                        .cornerRadius(8)
                                }
                                .padding()
                                
                                Button(action: {
                                    self.isLearningMode = false
                                    self.showScore = false
                                    self.totalScore = 0
                                }) {
                                    Text("Take Test Again")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                .padding()
                            }
                            
                            Button(action: {
                                self.isLanguageSelected = false
                                self.isLearningMode = true
                                self.showScore = false
                                self.totalScore = 0
                            }) {
                                Text("Return to Main Menu")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .cornerRadius(8)
                            }
                            .padding()
                        }
                    }
                }
                
                Spacer() // Pushes content to the middle of the screen
            }
        }
    }
    
    @State private var input = ""
    @State private var score = 0
    var player: AVPlayer? = nil
    
    // Function to check the translation
    private func checkTranslation() {
        if input.lowercased() == currentSessions[currentSessionIndex].translation.lowercased() {
            totalScore += 1
            score += 1
            isCorrect = true
            showAlert = true
        } else {
            isCorrect = false
            showAlert = true
        }
    }
    
    // Function to move to the next session
    private func nextSession() {
        if currentSessionIndex < min(currentSessions.count - 1, 9) {
            currentSessionIndex += 1
        } else {
            currentSessionIndex = 0
            showScore = true
        }
        input = ""
    }
    
    // Function to speak the word's pronunciation
    private func speak(word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "hi-IN") // Specify language for correct pronunciation
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
