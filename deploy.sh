docker build -t anoopkr05/multi-client:latest -t anoopkr05/multi-client:$SHA ./client/Dockerfile ./client
docker build -t anoopkr05/multi-server:latest -t anoopkr05/multi-server:$SHA ./server/Dockerfile ./server
docker build -t anoopkr05/multi-worker:latest -t anoopkr05/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push anoopkr05/multi-client:latest
docker push anoopkr05/multi-server:latest
docker push anoopkr05/multi-worker:latest
docker push anoopkr05/multi-client:$SHA
docker push anoopkr05/multi-server:$SHA
docker push anoopkr05/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anoopkr05/multi-server:$SHA
kubectl set image deployments/client-deployment client=anoopkr05/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anoopkr05/multi-worker:$SHA

