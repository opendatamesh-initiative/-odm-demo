 
#!/bin/sh
docker build -t dvdrental .
docker run -p 5433:5432 --name odm-demo-dvdrental --net host  dvdrental

