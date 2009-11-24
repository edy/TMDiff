#!/usr/bin/perl
# TMDiff - Time Machine Diff
#
# Copyright (c) 2007, Eduard Baun <eduard@baun.de>
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice,
#       this list of conditions and the following disclaimer in the documentation
#       and/or other materials provided with the distribution.
#     * Neither the name of TM Diff nor the names of its contributors
#       may be used to endorse or promote products derived from this software
#       without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# How to use:
# type in your terminal: perl timediff.pl <old> <new>
# where <old> represents the older backup dir and <new> the newer backup dir
#
# Example: perl tmdiff.pl /Volumes/Time\ Machine/Backups.backupdb/The\ White\ One/2007-11-01-201318/\
#                         /Volumes/Time\ Machine/Backups.backupdb/The\ White\ One/Latest/

if(@ARGV!=2) {
    print "Time Machine Diff 1.0\n";
    print "Usage: perl tmdiff.pl <old> <new>\n\n";
    print "<old> represents the older backup dir\n";
    print "<new> represents the newer backup dir\n";
    exit;
} else {
    our $older = $ARGV[0];
    our $newer = $ARGV[1];
    $newer =~ s/(\s)/\\$1/g;
    $older =~ s/(\s)/\\$1/g;
}

my $diff = open(DIFF, 'LANG="en_US" diff -r --brief '.$older.' '.$newer.' 2> /dev/null |') or die "error";

while(<DIFF>) {
    chomp($_);
    if ($_ =~ m/^Only in $older(.*)/i) {
        print "Deleted in $1\n";
    } elsif ($_ =~ m/^Only in $newer(.*)/i) {
        print "Added in $1\n";
    } elsif ($_ =~ m/^Files $older(.*?) and $newer(.*?) differ$/ig) {
        print "Changed: $1\n"
    }
    next;    
}

exit;