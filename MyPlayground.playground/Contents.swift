//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import Firebase

var fb = FirebaseInitial()
fb.CreateJson()
fb.SaveJsonToFile()
fb.LoadJsonFromFile()
fb.DownLoadFileFromFB()
