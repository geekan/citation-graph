for (( i=0; i < 16000; i += 2000 )); do echo "start: $i end: $((i+2000))"; sh get_xml.sh $i $((i+2000)); done

python analyse_xml.py xml_* >> files
