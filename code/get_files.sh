wget \
    --content-disposition \
    --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" \
    -A pdf \
    -i ./files \
    -P ./pdfs \
    -t 5 \
    -w 1 \
    -o wget.log
