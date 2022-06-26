#packet Transmission Rate
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
	printf ("Packet Transmission Rate is %f \n", (Packet_Received/Packet_Sent)*100);

	
}
