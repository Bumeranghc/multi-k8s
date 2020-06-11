docker build -t bumeranghc/multi-client:latest -t bumeranghc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bumeranghc/multi-server:latest -t bumeranghc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bumeranghc/multi-worker:latest -t bumeranghc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bumeranghc/multi-client:latest
docker push bumeranghc/multi-server:latest
docker push bumeranghc/multi-worker:latest

docker push bumeranghc/multi-client:$SHA
docker push bumeranghc/multi-server:$SHA
docker push bumeranghc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bumeranghc/multi-server:$SHA
kubectl set image deployments/client-deployment client=bumeranghc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bumeranghc/multi-worker:$SHA
