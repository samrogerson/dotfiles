#!/usr/bin/env python

#========================================================================
#      Copyright 2007 Raja <rajajs@gmail.com>
#
#      This program is free software; you can redistribute it and/or modify
#      it under the terms of the GNU General Public License as published by
#      the Free Software Foundation; either version 2 of the License, or
#      (at your option) any later version.
#
#      This program is distributed in the hope that it will be useful,
#      but WITHOUT ANY WARRANTY; without even the implied warranty of
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#      GNU General Public License for more details.
#
#      You should have received a copy of the GNU General Public License
#      along with this program; if not, write to the Free Software
#      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#==========================================================================

# ======================================================================
# Modified from code originally written by Baishampayan Ghose
# Copyright (C) 2006 Baishampayan Ghose <b.ghose@ubuntu.com>
# ======================================================================


import urllib2
import feedparser         

_url = "https://mail.google.com/gmail/feed/atom"

##################   Edit here      #######################

#pwd = xxxx                            # pwd stored in script
_pwdfile = '/home/samr/.gmail_notify_passwd'  # pwd stored in a file
_username = 'hyp3rfunk'
_calmcolor = 'white'
_alertcolor = 'red'
_maxmails = 5  # maximum new mails to show
_maxwords = 3  # maximum words to show in each mail header

###########################################################

def auth():
    pwd = open(_pwdfile).read()
    auth_handler = urllib2.HTTPBasicAuthHandler()
    auth_handler.add_password(
        realm='New mail feed',
        uri='https://mail.google.com',
        user='%s@gmail.com' % _username,
        passwd=pwd
    )
    opener = urllib2.build_opener(auth_handler)
    urllib2.install_opener(opener)
    feed = urllib2.urlopen('https://mail.google.com/mail/feed/atom')
    f = feed.read()
    return f

def showmail(feed):
    '''Parse the Atom feed and print a summary'''
    atom = feedparser.parse(feed)
    newmails = len(atom.entries)
    if newmails == 0:
        title = "^fg(%s) You have no new mails" % (_calmcolor)
    elif newmails == 1:
        title = "^fg(%s) You have 1 new mail"  % (_alertcolor)
    else:
        title = "^fg(%s) You have %s new mails" % (_alertcolor,newmails)
    
    # print the title with formatting
    print "^tw()" +title 
    #clear the slave window
    print "^cs()"
    
    #then print the messages
    for i in range(min(_maxmails,newmails)):
        
        emailtitle = atom.entries[i].title
        # show only first few words if title is too long
        if len(emailtitle.split()) > _maxwords:
            emailtitle = ' '.join(emailtitle.split()[:_maxwords])
            
        print "^fg(%s) %s from %s" % (_calmcolor, emailtitle, atom.entries[i].author)
    
if __name__ == "__main__":
    feed = auth()  
    showmail(feed)
