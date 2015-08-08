#!/usr/bin/perl -w

# Copyright (c) 2015 by S0bek.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# HOW TO USE:
#1) type "cpan" on your shell
#2) setup LWP::UserAgent module via the CPAN repo
#3) launch the program

use strict;
use LWP::UserAgent;

my ($url , $host_detail , $ip_detail , $ua , $host_req , $ip_req , $host_resp , $ip_resp , $details);

$url = "http://ifconfig.me";
$host_detail = "$url/host";
$ip_detail = "$url/ip";

$ua = LWP::UserAgent->new();
$host_req = HTTP::Request->new( GET => $host_detail );

$host_resp = $ua->request($host_req);
$details = $host_resp->decoded_content if ($host_resp->is_success);

$ip_req = HTTP::Request->new( GET => $ip_detail );
$ip_resp = $ua->request($ip_req);
$details = $details . $ip_resp->decoded_content if ($ip_resp->is_success);

print "Informations concernant votre adresse IP:\n$details\n";
