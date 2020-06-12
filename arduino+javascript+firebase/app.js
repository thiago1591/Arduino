
var firebase = require("firebase");

const firebaseConfig = {
    apiKey: "AIzaSyAHWgwRBuTGyqeyEfMjzfJMoGV-hDhNIJI",
    authDomain: "iot-teste2.firebaseapp.com",
    databaseURL: "https://iot-teste2.firebaseio.com",
    projectId: "iot-teste2",
    storageBucket: "iot-teste2.appspot.com",
    messagingSenderId: "649047679232",
    appId: "1:649047679232:web:5d19034120c0d4129653e5",
};
firebase.initializeApp(firebaseConfig);


var referencia = firebase.database().ref('LED/valor');


var five = require("johnny-five");


var board = new five.Board();

board.on("ready", function() {
    var rele = new five.Relay(7);    
    var estadorele = "OFF";          
  
    
    referencia.on('value', (snapshot) => {
        if (snapshot.val() == "ON") 
        {
            
          rele.off();}
        else   {       
            
            rele.on();}
    });

    
});