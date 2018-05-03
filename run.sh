SECONDS=0

rm report/*
declare -a tags=("search" "navigate-video")

for tag in "${tags[@]}"
do
	echo " - Running tests with tagged: $tag"
	$HOME/Library/Group\ Containers/group.com.docker/bin/docker run -v $PWD:/usr/src/app gunesmes/docker-capybara-chrome bash -c "cucumber features --tags @'$tag' --format json --out=report/'$tag'_report.json" &
done

wait
echo "\n - All processes done!"

duration=$SECONDS
echo " - $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed.\n"
