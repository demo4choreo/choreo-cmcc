
./nezha-agent -s ${NEZHA_URI} --tls -p ${NEZHA_SECRET} & 

python3 -m http.server 8080
