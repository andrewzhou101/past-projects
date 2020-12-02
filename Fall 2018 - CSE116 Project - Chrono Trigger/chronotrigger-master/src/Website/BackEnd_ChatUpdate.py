import time


def pp(username, message):
    if message == "UP":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "DOWN":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "LEFT":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "RIGHT":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "START":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "SELECT":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "X":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "Y":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "A":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "B":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "L":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    elif message == "R":
        username += " inputted command"
        mtype = "COMMAND"
        mtype = mtype.upper()
        return '[%s] [%s] %s "%s"' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
    else:
        username += ":"
        mtype = "MESSAGE"
        mtype = mtype.upper()
        return '[%s] [%s] %s %s' % (time.strftime('%H:%M:%S', time.localtime()), mtype, username, message)
