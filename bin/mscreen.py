#! /usr/bin/env python

from subprocess import check_output
from collections import defaultdict
from optparse import OptionParser

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


def main():
    options, args = opts()
    screens = get_screens()
    print(screens)


if __name__=='__main__':
    main()
