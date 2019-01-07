#!/usr/bin/python

from mininet.cli import CLI
from mininet.link import TCLink
from mininet.log import setLogLevel, info, lg
from mininet.net import Mininet
from mininet.node import Node
from mininet.topo import Topo
from mininet.util import waitListening


class NetTopo( Topo ):
    def __init__( self ):

        Topo.__init__(self)
        c1 = self.addHost('c1', ip = "11.0.0.1/24")
        c2 = self.addHost('c2', ip = "12.0.0.2/24")
	sv1 = self.addHost('sv1', ip = "11.0.0.3/24")
        s1 = self.addSwitch('s1')
        s2 = self.addSwitch('s2')
	s3 = self.addSwitch('s3')

	# Definieren der Netzwerkverbindungen (Start, Ziel, Geschwindikeit in Mbits, Paketverlust in Prozent)
        self.addLink(c1, s1, bw=10)
        self.addLink(c2, s1, bw=10)
	# Paketverlust auf der Hauptverbindung zwischen den Switches auf 30% setzen. Ein zu hoher Paketverlust verhindert den
	# aufbau der UDP Verbindung mit iperf3
        self.addLink(s1, s2, bw=10, loss=30)
	self.addLink(sv1, s2, bw=10)
	self.addLink(sv1, s2, bw=10)
	
	
	# Netzwerkverbindngen ohne Limitierung fuer die SSH Verbidungen zu den Hosts
	self.addLink(s3, c1)
	self.addLink(s3, c2)
	self.addLink(s3, sv1)

def sshd(net):
	root = Node( 'root', inNamespace=False )
    	intf = net.addLink(root, net['s3']).intf1
    	root.setIP('10.0.0.4/24', intf=intf)
	
	net.start()
	root.cmd('route add -net 10.0.0.0/24 dev ' + str( intf ))

	for host in net.hosts:
        	host.cmd('/usr/sbin/sshd -D -o UseDNS=no -u0&')
	

def routing(net):
	net['c1'].cmd("ifconfig c1-eth1 10.0.0.1/24")
	net['c2'].cmd("ifconfig c2-eth1 10.0.0.2/24")
	net['sv1'].cmd("ifconfig sv1-eth2 10.0.0.3/24")

	net['sv1'].cmd("ifconfig sv1-eth1 12.0.0.3/24")

if __name__ == '__main__':
	lg.setLogLevel( 'info')
	topo = NetTopo()
	net = Mininet(topo=topo, link=TCLink)

	routing(net)
	sshd(net)

	CLI(net)
	net.stop()
