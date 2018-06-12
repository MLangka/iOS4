# iOS4
Applikationsentwicklung unter iOS (WS2017/18) 4. Übung

Cocoa Touch: UIKit Kit Framework: Outlets, Actions und Delegates
In dieser Übung wird eine erste einfache Applikation für das iPhone erstellt. Das Programm soll die Währungen Euro, US-Dollar und britische Pfund ineinander umrechnen.
Hinweis: Orientieren Sie sich beim Bearbeiten dieser Aufgabe am Foliensatz 07-CocoaTouchGrundlagen.pptx.pdf.
 -Erstellen Sie eine Applikation mit folgenden Features:
  
  1. Der Benutzer soll Umrechnungskurse für 1 Euro in US-Dollar und 1 Euro in britische Pfund in entsprechende Textfelder eintragen können. Folgende Werte sollen voreingestellt sein (Stand 01.12.2017):
1 Euro = 1,1883 US-Dollar
1 Euro = 0,8810 britische Pfund.
Die Textfelder für die Währungskurse sollen die Zahlen mit all ihren Nachkommastellen anzeigen.
Hinweise:
Über die Property text eines UITextField können Sie die Eingabe als String? lesen bzw. setzen. 
In der 1. Übung haben Sie bereits einen String? in einen Double umgewandelt.
Mit String Interpolation können Sie einen Double in einen String schreiben.
Damit Sie sich nicht mit dem Thema "Auto-Layout" beschäftigen müssen, wählen Sie im Interface-Builder das Gerät (View as: ...), auf dem Sie im Simulator testen.
  
  2. In drei weiteren Textfeldern soll der Benutzer Beträge für Euro, britische Pfund und US-Dollar eingeben können. Wird eines dieser Textfelder durch eine Eingabe geändert, so sollen die beiden anderen Felder entsprechend der Umrechnungskurse neu berechnet werden. Die Ausgabe soll mit genau 2 Nachkommastellen erfolgen. 
Hinweise: 
Ein Double können Sie wie folgt in einen String mit 2 Nachkommastellen konvertieren: 
let myString = String(format: "%.2lf", myDoubleValue)
Um zu erfahren, dass der Benutzer ein Textfeld geändert hat, müssen Sie dem Feld eine Action vom Typ Editing Did End hinzufügen.
 
  3. Achten Sie darauf, dass die Anzeige jederzeit konsistent ist: Wenn immer Sie einen Währungsbetrag oder einen Umrechnungskurs ändern, müssen Sie ggf. die Werte für andere Textfelder neu berechnen.
 
  4. Sorgen Sie dafür, dass die Tastatur ausgeblendet wird, sobald deren Return-Taste gedrückt wird. Dazu müssen Sie Ihre ViewController-Klasse zum Delegate Ihrer UITextFields machen, dem ViewController das Protokoll UITextFieldDelegate und die folgende Methode hinzufügen:

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
}
  
  5.Fügen Sie einen Button hinzu, der die aktuellen Umrechnungskurse aus dem Internet herunterlädt. 
Bis Anfang des Jahres war dies sehr einfach durch die Abfrage geeigneter URLs bei Yahoo möglich. Als Rückgabe erhielt man einen Text, deren einziger Inhalt die Zahl für den Umrechnungskurs war. Dieser Service wurde leider eingestellt.
Eine Alternative ist ein vergleichbarer Service von Google:
https://finance.google.com/finance/converter?a=1&from=EUR&to=USD
https://finance.google.com/finance/converter?a=1&from=EUR&to=GBP
Dort bekommt man aber eine komplette Webseite zurück, die man nach dem Ergebniswert parsen muss. Gehen Sie wie folgt vor:
Erzeugen Sie aus dem Link eine Instanz der Klasse URL: URL(string: link).  
Laden sie den Inhalt der Webseite in einen String. Normaler Weise ist das Encoding UTF8. Diese Webseite funktioniert jedoch mit ISO Latin-1: String(contentsOf: url, encoding: .isoLatin1).
Suchen Sie in dem String nach dem Vorkommen von "1 EUR = <span class=bld>". Unmittelbar danach folgt die gesuchte Zahl. Diese endet mit einem Blank. (Rufen Sie den Link in einem Browser auf und schauen Sie sich den HTML-Quelltext einmal an.)
Extrahieren Sie die gesuchte Zahl als String und konvertieren Sie sie zu einem Double.
Hinweis: An vielen Stellen geben Ihnen die entsprechenden Methoden Optionals zurück, die Sie überprüfen müssen. An einer Stelle sind auch Exceptions möglich.
