echo running lab setup script for $1

echo curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$1.tar.gz
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$1.tar.gz

echo curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-$1-darwin-x86_64.tar.gz
curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-$1-darwin-x86_64.tar.gz


mkdir $1
mv elasticsearch-$1.tar.gz kibana-$1-darwin-x86_64.tar.gz $1

cd $1
echo working in $(pwd)
tar xzvf elasticsearch-$1.tar.gz
mv elasticsearch-$1 elasticsearch
tar xzvf kibana-$1-darwin-x86_64.tar.gz
mv kibana-$1-darwin-x86_64 kibana

echo disabling security by adding xpack.security.enabled: false to ymls

echo "xpack.security.enabled: false" >> elasticsearch/config/elasticsearch.yml
echo "xpack.security.enabled: false" >> kibana/config/kibana.yml



