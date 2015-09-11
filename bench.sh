#!/bin/bash
#####################################################################
# Benchmark Script 2 by Hidden Refuge from FreeVPS                  #
# Copyright(C) 2015 - Hidden Refuge                                 #
# License: GNU General Public License 3.0                           #
# Github: https://github.com/hidden-refuge/bench-sh-2               #
#####################################################################
# Original script by akamaras/camarg                                #
# Original: http://www.akamaras.com/linux/linux-server-info-script/ #
# Original Copyright (C) 2011 by akamaras/camarg                    #
#####################################################################
# The speed test was added by dmmcintyre3 from FreeVPS.us as a      #
# modification to the original script.                              #
# Modded Script: https://freevps.us/thread-2252.html                # 
# Copyright (C) 2011 by dmmcintyre3 for the modification            #
#####################################################################
sysinfo () {
	# Reading out system information...
	# Reading CPU model
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	# Reading amount of CPU cores
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	# Reading CPU frequency in MHz
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	# Reading total memory in MB
	tram=$( free -m | awk 'NR==2 {print $2}' )
	# Reading Swap in MB
	vram=$( free -m | awk 'NR==4 {print $2}' )
	# Reading system uptime
	up=$( uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }' )
	# Reading operating system and version (simple, didn't filter the strings at the end...)
	opsy=$( cat /etc/issue ) # Operating System & Version
	arch=$( uname -m ) # Architecture
	lbit=$( getconf LONG_BIT ) # Architecture in Bit
	hn=$( hostname ) # Hostname
	ipiv=$( wget -qO- ipv4.icanhazip.com )
	ipvii=$( wget -qO- ipv6.icanhazip.com )
	# Output of results
	echo "System Information"
	echo "------------------"
	echo "Processor: $cname"
	echo "CPU Cores: $cores"
	echo "Frequency: $freq MHz"
	echo "Memory: $tram MB"
	echo "Swap: $vram MB"
	echo "Uptime: $up"
	echo ""
	echo "OS: $opsy"
	echo "Arch: $arch ($lbit Bit)"
	echo "Hostname: $hn"
	echo "Public IPv4: $ipiv"
	echo "Public IPv6: $ipvii"
	echo ""
	echo ""
}
speedtest4 () {
	# Speed test via wget for IPv4 only with 10x 100 MB files. 1 GB bandwidth will be used!
	echo "Speedtest IPv4 only"
	echo "-------------------"
	# Cachefly CDN speed test
	echo "CDN - nearest location:"
	cachefly=$( wget -4 -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Cachefly: $cachefly "
	echo ""
	# United States speed test
	echo "America - United States:"
	coloatatl=$( wget -4 -O /dev/null http://speed.atl.coloat.com/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Coloat, Atlanta, GA: $coloatatl "
	sldltx=$( wget -4 -O /dev/null http://speedtest.dal05.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Dallas, TX: $sldltx "
	slwa=$( wget -4 -O /dev/null http://speedtest.sea01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Seattle, WA: $slwa "
	slsjc=$( wget -4 -O /dev/null http://speedtest.sjc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, San Jose, CA: $slsjc "
	slwdc=$( wget -4 -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Washington, DC: $slwdc "
	echo ""
	# Asia speed test
	echo "Asia:"
	linodejp=$( wget -4 -O /dev/null http://speedtest.tokyo.linode.com/100MB-tokyo.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Tokyo, Japan: $linodejp "
	slsg=$( wget -4 -O /dev/null http://speedtest.sng01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Singapore: $slsg "
	echo ""
	# Europe speed test
	echo "Europe:"
	i3d=$( wget -4 -O /dev/null http://mirror.i3d.net/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from i3d.net, Rotterdam, Netherlands: $i3d"
	leaseweb=$( wget -4 -O /dev/null http://mirror.leaseweb.com/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Leaseweb, Haarlem, Netherlands: $leaseweb "
	echo ""
	echo ""
}
speedtest6 () {
  	# Speed test via wget for IPv6 only with 10x 100 MB files. 1 GB bandwidth will be used! No CDN - Cachefly not IPv6 ready...
  	echo "Speedtest IPv6 only"
  	echo "-------------------"
  	# United States speed test
  	echo "America - United States:"
	v6atl=$( wget -6 -O /dev/null http://speedtest.atlanta.linode.com/100MB-atlanta.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Atlanta, GA: $v6atl"
  	v6dal=$( wget -6 -O /dev/null http://speedtest.dallas.linode.com/100MB-dallas.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Dallas, TX: $v6dal"
  	v6new=$( wget -6 -O /dev/null http://speedtest.newark.linode.com/100MB-newark.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Newark, NJ: $v6new"
	v6fre=$( wget -6 -O /dev/null http://speedtest.fremont.linode.com/100MB-fremont.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Fremont, CA: $v6fre"
  	v6chi=$( wget -6 -O /dev/null http://testfile.chi.steadfast.net/data.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Steadfast, Chicago, IL: $v6chi"
	echo ""
	# Asia speed test
	echo "Asia:"
  	v6tok=$( wget -6 -O /dev/null http://speedtest.tokyo.linode.com/100MB-tokyo.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Tokyo, Japan: $v6tok"
  	v6sin=$( wget -6 -O /dev/null http://speedtest.singapore.linode.com/100MB-singapore.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Singapore: $v6sin"
	echo ""
	# Europe speed test
	echo "Europe:"
	v6fra=$( wget -6 -O /dev/null http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Frankfurt, Germany: $v6fra"
        v6lon=$( wget -6 -O /dev/null http://speedtest.london.linode.com/100MB-london.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, London, UK: $v6lon"
        v6har=$( wget -6 -O /dev/null http://mirror.nl.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
        echo "Download speed from Leaseweb, Haarlem, Netherlands: $v6har"
	echo ""
	echo ""
}
iotest () {
	# Measuring disk speed with DD
	io=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' )
	io2=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' )
	io3=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' )
	# Output of DD result
	echo "Drive Speed:"
	echo "------------"
	echo "I/O (1st attempt): $io"
	echo "I/O (2nd attempt): $io2"
	echo "I/O (3rd attempt): $io3"
	# Calculating avg I/O
	ioraw=$( echo $io | awk 'NR==1 {print $1}' )
	ioraw2=$( echo $io2 | awk 'NR==1 {print $1}' )
	ioraw3=$( echo $io3 | awk 'NR==1 {print $1}' )
	ioall=$( expr $ioraw + $ioraw2 + $ioraw3 )
	ioavg=$( expr $ioall / 3 )
	echo "Average I/O: $ioavg MB/s"
	echo ""
}
case $1 in
	'-sysinfo')
		sysinfo;;
	'-io')
		iotest;;
	'-6' )
		sysinfo; speedtest6; iotest;;
	'-46' )
		sysinfo; speedtest4; speedtest6; iotest;;
	*)
		sysinfo; speedtest4; iotest;;
esac
