#!/bin/bash

SECONDS=0
capybara_image=gunesmes/docker-capybara-chrome:latest


echo " - Get the latest docker images"
docker pull ${capybara_image}

echo -e "\n - Test running on \n    https://www.gittigidiyor.com\n\n"

rm -rf report/*

for tag in \
	"basket" 
	do

	for platform in \
		"desktop" \
		"mobile_iphone6_v" \
		"mobile_iphone6_h" \
		"mobile_iphone6plus_v" \
		"mobile_iphone6plus_h" \
		"mobile_samsungs6_v" \
		"mobile_samsungs6_h" \
		"samsungsTabA_h" \
		"mobile_samsungsTabA_v" \
		"mobile_samsungsTabA_h" \
		"driver_ipad_v" \
		"driver_ipad_h"
		do
			
		run_name=test_${tag}_on_${platform}
		run_command="--tags @$tag --tags @$platform DRIVER=driver_$platform"
		echo " - Running tests: $tag on $platform"
		
		docker run --shm-size 32M --name ${run_name} -v $PWD:/usr/src/app ${capybara_image} bash -c "cucumber features --tags @'$tag' --format json --out=report/${run_name}_report.json RUN_COMMAND=\"$run_command\" DRIVER=driver_$platform && exit 0" && echo "Finished $tag on $platform:" && duration=$SECONDS && echo -e " - $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed.\n" && docker rm -f ${run_name} &
	done
done


echo -e "\n - - - - - -  RESULT  - - - - - - - "

wait
echo -e "\n - All processes done!"

duration_total=$SECONDS
echo -e " - $(($duration_total / 60)) minutes and $(($duration_total % 60)) seconds elapsed.\n"

docker ps -a > ./docker-list.txt
> ./docker-logs.txt

for var in $(docker ps -a|grep capybara|awk '{print $1}')
do 
echo --------------------------- >> ./docker-logs.txt
echo "Logs of docker-"$var >> ./docker-logs.txt
docker logs $var >> ./docker-logs.txt
echo --------------------------- >> ./docker-logs.txt
done

prefix=${branch_name}_qa_
for var in $(docker ps -a|grep ${prefix}|awk -F ${prefix} '{print $2}') 
do
	docker rm -f ${prefix}${var} &
done

nohup docker system prune -f &