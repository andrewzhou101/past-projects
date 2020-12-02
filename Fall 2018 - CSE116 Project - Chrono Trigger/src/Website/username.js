function ajaxGetRequest(path, callback){
    var request = new XMLHttpRequest();
    request.onreadystatechange = function(){
        if (this.readyState === 4 && this.status === 200){
            callback(this.response);
        }
    };
    request.open("GET", path, true);
    request.send();
}

function ajaxPostRequest(path, data, callback){
    var request = new XMLHttpRequest();
    request.onreadystatechange = function(){
        if (this.readyState === 4 && this.status === 200){
            callback(this.response);
        }
    };
    request.open("POST", path, true);
    request.send(data);
}

function clearer(){
    document.getElementById("chatbox").innerHTML = ""
}

function addName() {
    function clear(){
        document.getElementById("addname").value = "";
    }
    var name = document.getElementById("addName").value;
    alert("PEAVCE");
    if (button.onclick == true){
        var txt = JSON.parse({"User":name});
        var toSend = JSON.stringify(txt);
    }
    ajaxPostRequest("/addName", toSend, clear());
    }

function getNameList() {
    ajaxGetRequest("/getNameList", "nameList")
}
