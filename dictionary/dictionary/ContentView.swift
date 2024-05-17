//
//  ContentView.swift
//  dictionary
//
//  Created by Wang, Alyssa on 3/11/24.
//

import SwiftUI
import AVFAudio



struct ContentView: View {
@State private var name  = ""
@State private var words = ["misanthropy", "apologetic", "delicacy", "unholy", "remaster", "catalexis", "disorder", "laceration", "hillcrest", "predestine", "sawbones", "mishanter"]
    
@State private var defs = ["Noun - Hatred or mistrust of humankind.", "Noun - A formal defense or apology.", "Noun - The quality of being delicate.", "Adjective - Wicked; immoral.", "Verb - To master again, especially to produce a new master recording of (an old recording) in order to improve the sound quality.", "Noun - The absence of one or more syllables in a line of verse, especially in the last foot.", "Verb - To upset the normal functions or health of","Noun - A jagged wound or cut.", "Noun - The summit line of a hill.", "Verb - to destine or decree beforehand; foreordain", "Noun - A physician, especially a surgeon.", "Noun - mishap; misadventure"]
    
    
    @State var audioPlayer: AVAudioPlayer!
    
    @State private var text = ""
    
    @State private var homeScreenOn = true
    
    @State private var index = 0
    @State private var newIndex = 0
    
    @State private var error = ""

   // @State private var definition:String

    @State private var listScreenOn = false
    @State private var wordRevealOn = false
    //@State private var menuOn = false
  //  @State private var addPageOn = false
    @State private var randButton = false
    
    
    @State private var newWord1 = ""
    @State private var newDef1 = ""
    
    @State private var wordAdded = ""
    
    var body: some View {
        VStack {
            
            
           
            
            Group {
                HStack {
//                    Button("Menu") {
//                        if(menuOn == false) {
//                            menuOn = true
//                        }
//                        else{
//                            menuOn = false
//
//                        }
//
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .tint(.indigo)
                    
                    if (!homeScreenOn) {
                        Button("    ") {
                            homeScreenOn = true
                            listScreenOn = false
                            randButton = false
                            wordAdded = ""
                            playSound(soundName: "click")
                        }
                        
                        .buttonStyle(.borderedProminent)
                        .padding(.trailing, -40.0)
                        .tint(.indigo)
                        Image(systemName: "house")
                            .foregroundColor(.white)
                    }
                    if homeScreenOn && !listScreenOn {
                        
                        //                    error = " "
                        
                        Button("Random word") {
                            index = Int.random(in:0...words.count - 1)
                            homeScreenOn = false
                            error = ""
                            randButton = true
                            playSound(soundName: "click")
                        }
                        .buttonStyle(.borderedProminent)
//                        .padding(.leading, 25.0)
                        .font(.system(size: 18))
                        .tint(.indigo)
                        .padding()
                        
                        
                        
                        
                        
                        
                        Button("Learn the words") {
                            
                            listScreenOn = true
                            homeScreenOn = false
                            playSound(soundName: "click")
                            
                        }
                        .buttonStyle(.borderedProminent)
//                        .padding(.trailing, 2)
//                        .padding(.leading, 20)
                        .tint(.indigo)
                        .padding()
                        .font(.system(size: 18))
                    }
                }
                
                
                
                Spacer()
                Text("Vocabulary")
                
                    .font(.system(size:50))
                    .fontWeight(.light)
                    .tint(.black)
                    .padding()
                
                Spacer()
                
                if (homeScreenOn) {
                    Image(systemName: "text.book.closed.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 225)
                        .padding(.bottom, -100)
                        .foregroundColor(Color("BookColor"))
//                        .foregroundColor(
//                            Gradient(colors: [Color("BookColor"), .indigo])
//                        )
                    

                  
                }
               
                
                if listScreenOn {
                    
                    VStack {
                        
                        Spacer()
                        
                        var newWord = words[newIndex]
                        Text(newWord)
                            .font(.largeTitle)
                            .animation(.easeIn(duration: 0.1))
                            .padding()
                            //.frame(height: 60)
                        
                        
                    
                        if wordRevealOn {
                            Text( defs[newIndex])
                               // .frame(height: 60)

                        }
                        
                        HStack {
                            
                            
                            
                            Button("<") {
                                playSound(soundName: "click")
                                wordRevealOn = false
                                if newIndex > 0 {
                                    newIndex -= 1
                                } else {
                                    newIndex = defs.count - 1
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .padding()
                            
                            Button (">") {
                                playSound(soundName: "click")
                                wordRevealOn = false
                                if newIndex < defs.count - 1 {
                                    newIndex += 1
                                } else {
                                    newIndex = 0
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .padding()
                        }
                        
                        Button("Reveal Definition") {
                            playSound(soundName: "click")
                            wordRevealOn = true
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        
                        Spacer()
                        
                        
                        TextField("Enter the new word", text: $newWord1)
                            .textFieldStyle(.roundedBorder)
                        TextField("Enter the definition", text: $newDef1)
                            .textFieldStyle(.roundedBorder)
                        
                        Text(wordAdded)
//                            .animation(.easeInOut(duration: 0.3))
                    
                                      
                        
                        Button("Add new words") {
                           
                            if (newWord1.isEmpty || newDef1.isEmpty ) {
                                wordAdded = "Please enter the information."
                                playSound(soundName: "wrong")
                                
                            } else {
                                words.append(newWord1.lowercased())
                                defs.append(newDef1.lowercased())
                                newWord1 = ""
                                newDef1 = ""
                                wordAdded = "Word added!"
                                playSound(soundName: "correct")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        .tint(.indigo)
                        
                    }
                }
            }
                Spacer()
                
                
                
                Spacer()
                
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .padding()
                
                Text(error)
                
                
                
          
                if homeScreenOn && !listScreenOn {
                    
                    
                    HStack {
                        TextField("Enter a word", text: $name)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("enter") {
                            playSound(soundName: "click")
                            index = 0
                            if (name == "") {
                                error = "Please enter your word."
                                playSound(soundName: "wrong")
                            }
                            else if (!words.contains(name.lowercased())) {
                                
                                error = "Word does not exist in your list. Try again. "
                                playSound(soundName: "wrong")
                            }
                            
                            else if (words.contains(name.lowercased())) {
                                
                                for word in words {
                                    if (word == name.lowercased()) {
                                        homeScreenOn = false
                                        error = ""
                                        break
                                        
                                    } else {
                                        index += 1
                                    }
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        .tint(.indigo)
                        
                    }
                    
                    Spacer()
                    
                } else if listScreenOn == false {
                    Spacer()
                    VStack {
                        
                        Spacer()
                        var str = String(defs[index])
                        Text(words[index])
                            .font(.system(size: 40))
                            .padding()
                        
                        Text(str)
                        
                        Spacer()
                        
                        if (!randButton) {
                            Button("Search Again") {
                                playSound(soundName: "click")
                                // index = Int.random(in:0...words.count - 1)
                                homeScreenOn = true
                                name = ""
                                randButton = false
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        if(randButton) {
                            Button("Random Word"){
                                playSound(soundName: "click")
                                index = Int.random(in:0...words.count - 1)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        Spacer()
                        Spacer()
                        
                    }
                    
                }
            
                
            
        }
        
        
        
        .padding()
        
        
    }
    
    func playSound(soundName: String) {
           guard let soundFile = NSDataAsset(name: soundName) else
           {
               print("❅")
               return
           }
           do {
               audioPlayer = try AVAudioPlayer(data: soundFile.data)
               audioPlayer.play()
           } catch {
               print("BOMBOCLATT")
               
           }
       }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
