cd (dirname (status -f))

STATE=$(cat .brightstate)

case $argv[1]
    case get
        echo $STATE
        exit 0
    case inc
