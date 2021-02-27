docker build  -t mpq1990/multi-client:latest -t mpq1990/multi-client:$SHA -f ./client/Dockerfile ./client
docker build  -t mpq1990/multi-server:latest -t mpq1990/multi-server:$SHA -f ./server/Dockerfile ./server
docker build  -t mpq1990/multi-worker:latest -t mpq1990/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mpq1990/multi-client
docker push mpq1990/multi-server
docker push mpq1990/multi-worker
docker push mpq1990/multi-client:$SHA
docker push mpq1990/multi-server:$SHA
docker push mpq1990/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mpq1990/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=mpq1990/multi-worker:$SHA
kubectl set image deployments/client-deployment client=mpq1990/multi-client:$SHA