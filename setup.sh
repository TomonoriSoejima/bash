echo running lab setup script for $1

# 7.x https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.0-darwin-x86_64.tar.gz

elasticsearch=""
if [ $(echo $1 | cut -c1) -le 6 ];
then
	elasticsearch=elasticsearch-$1.tar.gz
else
  echo it is 7
  	elasticsearch=elasticsearch-$1-darwin-x86_64.tar.gz

 fi


# 6.x https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.1.tar.gz
echo curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/$elasticsearch
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/$elasticsearch


echo curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-$1-darwin-x86_64.tar.gz
curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-$1-darwin-x86_64.tar.gz


mkdir $1
mv $elasticsearch kibana-$1-darwin-x86_64.tar.gz $1


while sleep
cd $1
echo working in $(pwd)
tar xzvf $elasticsearch
mv elasticsearch-$1 elasticsearch
tar xzvf kibana-$1-darwin-x86_64.tar.gz
mv kibana-$1-darwin-x86_64 kibana

echo disabling security by adding xpack.security.enabled: false to ymls

echo "xpack.security.enabled: false" >> elasticsearch/config/elasticsearch.yml
echo "xpack.security.enabled: false" >> kibana/config/kibana.yml
echo "logging.dest: /Users/surfer/elastic/labs/$1/kibana/kibana.log" >> kibana/config/kibana.yml

echo making a start up script

echo "./elasticsearch/bin/elasticsearch -d" >> start.sh
echo "./kibana/bin/kibana &" >> start.sh

./start.sh

sleep 15

