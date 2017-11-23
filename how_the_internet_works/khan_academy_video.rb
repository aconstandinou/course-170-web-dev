#################### WIRES, CABLES, WIFI###################

Internet ships binary information, made up of bits.
Bits: on or off (like yes or no) 1 = on, 0 = off.
      since theres only two states, its called binary

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


#################### IP ADDRESSES AND DNS ###################

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
    user is sent to a fake website, whether knowingly or not.

################### PACKET, ROUTERS, RELIABILITY ###################

How is our data transmitted correctly?
Ex: play a song from Spotify

Data travels in a much less direct fashion.
Computer to computer path may change as its happening.

# Packet
Data is transferred via a packet (think amazon box) and is transferred along
  different pathways. Like traffic or congestion, it can take a different path
  at any moment

Giant packets need to be broken down and sent in pieces, and will arrive at
  different times, is then re-assembled.

Each packet has the IP address of where it came from and to where its going.

# Routers
Routers: act as traffic managers to keep packets moving smoothly.
        finds cheapest available path for each piece of data.
        "cheapest" = time, politics, relationships between companies

Reliability: fault tolerant as packets can be sent even if pathways are broken.

Back to Spotify song ex. How do we get it to play perfectly?

# TCP
TCP: Transmission Control Protocol - manages the sending and receiving of data.
                                      kind of like a guaranteed mail service.

When received, TCP runs a full check of inventory and sends a message back
  acknowledging that. If all packets are there, TCP signs for the delivery.
  If anything missing, TCP does not sign for it.
  Spotify will resend any missing packets. Then once approved, song will play.

More Routers = More Reliable the internet becomes.

################### HTTP and HTML ###################


Ex: accessing the internet through a browser.

1. Open Web Browser = app to access internet. ie: Internet Explorer, Mozilla, Chrome.

2. Type in web address (url: uniform resource locator) and pc communicates with server
     to receive web address of the target site. This communication is known as HTTP.

2. a) HTTP ((H)yper(T)ext (T)ransfer (P)rotocol): language for device to request from
                                                  other device for document.
   main language is "GET" requests.
   GET document-being-requested
   lets say were requesting Tumblr login page. Its requesting the html page for login.

3. HTML ((H)yper (T)ext (M)arkup (L)anguage)
  On a webpage, all the text is included in HTML, but links and videos, etc. are
  sent as separate HTTP requests.
  Ex: image being loaded on wikipedia page. Server sends HTTP data for image and
      its loaded as we are waiting for page to load.

4. Sometimes when we submit info (ie: search engine or filling out a form),
   we send info via "POST" requests.

5. Accessing our Tumblr login page, once the server accepts login as correct,
  it not only sends along the home page, but a hidden piece of data "COOKIE"

6. "COOKIE": data is an ID card for Tumblr to identify you, so the next time
            you refresh Tumblr or go to Tumblr.com, web browser knows to automatically
            attach that ID number with request over to Tumblr server.

7. Secure Sockets Layer: to allow communication to be protected and private.
                        SSL, and TLS are active when you see little lock next to https
                        When server wants to communicate safely, it provides a
                        DIGITAL CERTIFICATE (like an official ID card) proving that
                        its the website its meant to be.

8. Digital Certificates: issued by Certificate Authorities who are trusted entities
                        that verify identities of websites and issue them certificates.

9. If website tries to communicate without a proper certificate, browser will warn you.


Summary, HTTP & DNS manage the sending/receiving of web files (or anything on the web)
This is allowed via TCP/IP and Router Networks that break down and transport packets.
Packets are made up of binary (1s and 0s) physically sent through wires, fiber optic cables,
and wifi networks.
