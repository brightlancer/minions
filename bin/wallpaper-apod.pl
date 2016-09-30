#!/usr/bin/perl
#
# $Header: /root/scripts/wallpaper-apod.pl,v 1.2 2010-01-08 05:03:40 brlancer Exp $
#
# Copyright © 2009 Don Lachlan <don.lachlan@unpopularminds.org>
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, version 2.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc., 51
# Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#
# THIS fetches the current NASA Astronomy Picture Of the Day
#

use strict;
#use warnings;

sub DEBUG { }   # Set to 1 for developer debug mode

if (DEBUG()) {
  print "DEBUG: ";
  print time();
  print ": Starting $0\n";
}

my $apodsite = "http://antwrp.gsfc.nasa.gov";
my $apoddir = "apod";
my $tmpdir = "/tmp";
my $apodimg = "apod-daily.jpg";
my $setbg_exec = "/usr/bin/wmsetbg";
my $setbg_opts = "-b black -S -a";

if (DEBUG()) {
  print "DEBUG: ";
  print time();
  print ": Fetching APOD.\n";
}
my $w = `wget -O - ${apodsite}/${apoddir} 2>&1`;
$w =~ /href=(.+?\.(png|jpg|jpeg|gif))/i;
my $i = $1;
$i =~ s/^\"//;
if (DEBUG()) {
  print "DEBUG: ";
  print time();
  print ": Parsing image name.\n";
}
unless ($i =~ /^http/) {
  if (DEBUG()) {
    print "DEBUG: ";
    print time();
    print ": No leading http.\n";
  }
  unless ($i =~ /^\//) {
    if (DEBUG()) {
      print "DEBUG: ";
      print time();
      print ": No leading directory slash.\n";
    }
    $i = "${apoddir}/${i}" ;
  }
  $i = "${apodsite}/${i}" ;
}
if (DEBUG()) {
  print "DEBUG: ";
  print time();
  print ": Fetching APOD image.\n";
}
`wget -O ${tmpdir}/${apodimg} ${i} 2>&1` ;
if (DEBUG()) {
  print "DEBUG: ";
  print time();
  print ": Setting background image to APOD.\n";
}
`${setbg_exec} ${setbg_opts} ${tmpdir}/${apodimg}` ;
if (DEBUG()) {
  print "DEBUG: ";
  print time() . "\n";
}
