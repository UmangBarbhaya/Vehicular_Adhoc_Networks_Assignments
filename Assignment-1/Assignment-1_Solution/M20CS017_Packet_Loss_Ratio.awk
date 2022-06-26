#packet Loss Ratio
BEGIN {
	Packet_Sent =0
	Packet_Received=0
}

{
packet=$19
event = $1
if(event =="s" && packet == "AGT") {
	Packet_Sent++;
}

if(event =="r" && packet == "AGT") {
	Packet_Received++;
}

}

END {
	printf ("Packet Sent %d \n", Packet_Sent);
	printf ("Packets Received %d \n", Packet_Received);
	printf ("Packet Loss Ratio is %f \n", ((Packet_Sent-Packet_Received)/Packet_Sent));

	
}
