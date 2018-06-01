MINIKUBE_TARGET_SERVICE=webapp

bootstrap:
	auto/mac-install-minikube.sh
	brew install kubernetes-cli

cluster:
	auto/minikube-start.sh --vm-driver hyperkit
uncluster:
	@minikube stop
	@minikube delete
recluster: uncluster cluster

deploy:
	kubectl apply -f k8s
undeploy:
	kubectl delete -f k8s
redeploy: undeploy deploy

service_open:
	minikube service "${MINIKUBE_TARGET_SERVICE}"
service_url:
	@minikube service "${MINIKUBE_TARGET_SERVICE}" --url

chaos:
	@auto/chaos.sh
