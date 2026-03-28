
var ai = true
var dungu = true
var player = true
var game = bagus
var cheater = false
var rating = 100
var skill = jago
var grafik = rtx2090


func _ready():
    while ai:
        if dungu && player:
            ai = true
            print("Maaf, aku skill issue, aku tidak bisa bermain dengan baik. makanya aku pakai ai")
        elif !dungu && player:
            ai = false
            print("apa coba ai")
        else
            ai = true
            print("aku ai")