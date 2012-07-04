#! /usr/bin/env python

from subprocess import check_output
from collections import defaultdict
from optparse import OptionParser

import tkinter as tk

def opts():
    parser = OptionParser("usage: %prog [options] [args]")
    parser.add_option("-o", "--output", action="store", dest="one_screen"  ,
                      default=None, metavar="SCREEN",
                      help="Set output to one display")
    options,args = parser.parse_args()
    return options, args

def get_screens(screen_types = ["LVDS", "VGA"]):
    xrandr_out = check_output('xrandr')
    xrandr = str(xrandr_out, encoding='utf8').split('\n')

    screens = defaultdict(dict)
    current_screen_type = None

    for line_num, line in enumerate(xrandr):
        fields = line.split()
        is_screen_type = [ pos for pos, scr in enumerate(screen_types)
                           if line.startswith(scr)]
        if len(is_screen_type) > 0 and 'connected' in fields:
            screen_type = fields[0]
            current_screen_type = screen_type
        elif current_screen_type is not None:
            # we've actually found a screen already, so this is a res line
            if len(fields) > 0 and "+" in fields[-1]:
                # this is the preferred mode
                res = fields[0]
                ref = fields[1].rstrip('+*')
                screens[current_screen_type]['resolution'] = res
                screens[current_screen_type]['refresh_rate'] = ref
    return screens

def spawn_screen():

    def reply():
        from tkinter.messagebox import showinfo
        showinfo(title='popup', message='button pressed')

    def print_it(event):
        print(var.get())

    window = tk.Tk()
    #button = tk.Button(window, text='press', command=reply)
    #button.pack()
    #window.mainloop()

    var = tk.StringVar()
    var.set("a")
    omenu = tk.OptionMenu(window, var, "a","b","c", command=print_it)
    omenu.pack()
    window.mainloop()


def main():
    spawn_screen()
    #options, args = opts()
    #screens = get_screens()
    #print(screens)


if __name__=='__main__':
    main()
