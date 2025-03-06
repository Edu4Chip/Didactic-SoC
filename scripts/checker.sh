RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $(diff $1 $2) ]]; then
	printf "Checker ${RED}[FAILED]${NC}\n"
	echo "Compare to reference & fix result"
else
	printf "Checker ${GREEN}[PASSED]${NC}\n"
	echo "Application functionality OK"
fi

