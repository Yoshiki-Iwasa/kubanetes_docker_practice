#!bin/zsh


while true
do
    kubectl get svc | grep wp-service > /dev/null
	ret=$?
	if [ ret = 0 ]
		break
done
