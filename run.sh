#!/bin/bash

SECONDS=0

# remove the report folder for new reports
rm report/*

# add the cucumber tags in this list
declare -a tags=(
	"search" \
	"navigate-video"
	)

# pull the latest version of the images if not available locally 
docker pull gunesmes/docker-capybara-chrome:latest

for tag in "${tags[@]}"
do
	echo " - Running tests with tagged: $tag"
	docker run -v $PWD:/usr/src/app gunesmes/docker-capybara-chrome:latest bash -c "cucumber features --tags @'$tag' --format json --out=report/'$tag'_report.json" &
done

wait
echo "\n - All processes done!"

duration=$SECONDS
echo " - $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed.\n"
