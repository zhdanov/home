#!/bin/bash

NS=albums-prod
POD=albums-prod-0

kubectl -n $NS exec -it $POD -c lychee -- chown -R www-data:www-data /conf
kubectl -n $NS exec -it $POD -c lychee -- chmod 777 /conf
kubectl -n $NS exec -it $POD -c lychee -- chown -R www-data:www-data /uploads
kubectl -n $NS exec -it $POD -c lychee -- chmod 777 /uploads
kubectl -n $NS exec -it $POD -c lychee -- chown -R www-data:www-data /sym
kubectl -n $NS exec -it $POD -c lychee -- chmod 777 /sym
kubectl -n $NS exec -it $POD -c lychee -- chown -R www-data:www-data /var/www/html/Lychee

kubectl -n $NS exec -it $POD -c lychee -- sh -c 'echo ".album .overlay, .photo .overlay {background-color: #1d1d1d;}" >> /var/www/html/Lychee/public/dist/frontend.css'
