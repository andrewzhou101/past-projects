from bottle import get, post, request, route, static_file, run, error, response
import json
import Website.BackEnd_key
import  Website.user


@route('/')
def server():
    return static_file("page.html", root="")


@route('/keyA')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("A"))


@route('/keyB')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("B"))


@route('/keyX')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("X"))


@route('/keyY')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("Y"))


@route('/keyL')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("L"))


@route('/keyR')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("R"))


@route('/keyLeft')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("LEFT"))


@route('/keyRight')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("RIGHT"))


@route('/keyUp')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("UP"))


@route('/keyDown')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("DOWN"))


@route('/keySelect')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("SELECT"))


@route('/keyStart')
def backend_key():
    return Website.BackEnd_key.send_key(json.dumps("START"))


@route("/cookie")
def cookie():
    return static_file("cookie.js", root="")


@post('/addName')
def addnewUser():
    return static_file("username.js", root="")


@get('/getNameList')
def allNameinList():
    return static_file("username.js", root="")


@error(404)
def error404(error):
    return "Holy fucking shit. I want to bang Zero Two so goddamn bad. I can't stand it anymore. Any time there’s a scene with Zero Two, I get a massive erection. I've seen literally every rule 34 post there is of her online. My dreams are nothing but constant fucking sex with Zero Two. I'm sick of waking up every morning with six nuts in my boxers and knowing that those are nuts that should've been busted inside of Zero Two’s tight dino pussy. God I wish I was Hiro because I fucking know for a fact that Zero Two drains his balls daily. I want her to suck all of my humanity out and ride me to death. Anyways, do you guys relate to this?"

#Ben IPv4 = 10.84.23.177
#Andrew IPv4 = 10.84.41.82
run(host="10.84.23.177", port=8080, debug=True)
