#!/bin/bash

for serverThreads in {1..20}
do
	linea=$serverThreads";"
	for clients in {1..60}
	do
		echo $serverThreads" threads en servidor"
		echo $clients" clientes corriendo"

		repetitions=20
		for ((i=1 ; $i<=$repetitions ; i++))
		{
			./server $serverThreads 1 >> aux &
			pid=$!
			sleep 1

			for ((j=1 ; $j<=$clients ; j++))
			{
				./client 1 127.0.0.1 > /dev/null &
			}
			wait $pid
			linea="$linea$(cat aux)"
			rm aux
		}
		linea="$linea;"
	done
	echo "$linea" >> server_client_relation.csv
done