# WIRES, CABLES, WIFI

Internet ships binary information, made up of bits.
Bits: on or off (like yes or no) 1 = on, 0 = off.
      binary

8 bits = 1 byte
1000 bytes = 1 kilobyte
1000 kilobytes = 1 megabyte

But what is actually getting sent over wires?
We physically send bits by electricity, light, radio waves.
  recall: 1s and 0s

What if we want to send many 0s? We wouldnt know how many are sent until we
  introduce time. ex: send 1 bit per second.

How do we increase our speed for this transmission? Increase bandwidth.
  Bandwidth measured by bitrate.
  Bitrate = number of bits per second a system can transmit.
  Latency = time it takes for one bit to travel from sender to receiver.

Speed: so if we want to download a 3 megabyte (MB) song in 3 seconds.
       8_000_000 bits = 1 megabyte
       Bitrate = 8 Mbps

CABLES

- Ethernet: measurable signal loss (interference) over 100 feet.

Whats the alternative? Light!

Fiber Optic Cables: transmit light which is much quicker.
                    thread of glass and light is passed through (bouncing through at the speed of light)

WIFI: use radio signals to transmit bits. They need to convert bits to radio signal,
      and once received, they need to reconvert back to bits.


# IP ADDRESSES AND DNS

Vint Cerf & Bob Kahn: set up the internetworking protocol as a standard

Internet: network of networks linking billions of devices.

Device connects to WIFI, WIFI connect to Internet Service Provider (ISP)
  and that ISP connects to billions of devices through networks all inter-connected.

Internet: design philosophy and architecture expressed as a set of protocols.

Protocol: known set of rules and standards that if agreed to, allows communication
          between machines.

Each device: possesses a unique address (IP ADDRESS), think of a mailing address.

IP (Internet Protocol): how to give an address to a device. Devices communicates
                        with other devices and provides IP address (sharing of info)

ie: 174.129.14.120

Each number is represented as bits. Each part is 8 bits for a total of 32 bits.

IPv4: developed in 1970s. (max 4 billion devices)
IPv6: currently being implemented with 128 bits

DNS: Domain Name System
   - associates names like www.example.com with corresponding addresses.
   - pc uses DNS to look up domain names and the associated IP address used
     to connect your computer to the destination.

DNS system needs to be elaborate... all the billions of devices cannot rely on
   one DNS server to get all these addresses.

DNS are connected in a distributed hierarchy, divided into zones.
  Responsibility is split up for the major domains, ie: .org, .com, .ca, etc.

DNS originally built to be open for government and schools, also makes it
  susceptible to cyber attacks.

ex: DNS spoofing. Hacker hacks into DNS and changes the address of a given site.


# PACKET, ROUTERS, RELIABILITY

How is our data transmitted correctly?
Ex: play a song from Spotify


























.
