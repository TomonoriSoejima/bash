out="out.json"

for i in $(seq 1 8); do
    curl https://api.github.com/orgs/logstash-plugins/repos?page=$i >> $out
done

cat $out | jq '.[].clone_url' | grep input | xargs -L 1 git clone
