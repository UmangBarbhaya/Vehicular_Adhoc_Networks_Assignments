#Throughput
BEGIN {
	recv_size=0
	startingTime=1e6
	stoppingTime=0
	recordCount=0
}
#This awk file works only for new trace format, old trace does not have support
{
packet_id=$41
packet_size=$37
flowType=$45
event =$1
time=$3
packet=$19


if(packet=="AGT" && sendTime[packet_id] == 0 && (event == "+" || event == "s")) {
	if (time < startingTime) {
		startingTime=time
	}
	sendTime[packet_id] = time
	this_flow=flowType
}

if(packet=="AGT" && event == "r") {
	if(time >stoppingTime) {
		stoppingTime=time
	}
	recv_size = recv_size + packet_size
	recvTime[packet_id] = time
	recordCount = recordCount + 1
}
if(event =="s" && packet == "AGT") {
	Packet_Sent++;
}

if(event =="r" && packet == "AGT") {
	Packet_Received++;
}
}

END {
	if (recordCount ==0) {
		printf("No packets, the simulation might be very small \n")
	}
	printf ("Efficiency : %f\n", (100 -( (stoppingTime - startingTime) / (((100 - (((Packet_Sent-Packet_Received)/Packet_Received)*100)) * Packet_Received) / (stoppingTime - startingTime)))))		
}
