import unittest
import Website.BackEnd_key
import win32ui
import sys
import json

json_up = json.dumps("UP")
json_down = json.dumps("DOWN")
json_left = json.dumps("LEFT")
json_right = json.dumps("RIGHT")
json_start = json.dumps("START")
json_a = json.dumps("A")
json_win = json.dumps("WINDOWS")


class MyTestCase(unittest.TestCase):
    def test_something(self):
        Website.BackEnd_key.set_username("PLACEHOLDER")
        self.assertEqual(Website.BackEnd_key.send_key(json_up), None)


if __name__ == "__main__":
    win = win32ui.FindWindow(None, sys.argv[1])
    win.SetbForegroundWindow()
    win.SetFocus()
    Website.BackEnd_key.send_key(sys.argv[2])
