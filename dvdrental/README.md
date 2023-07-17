# dvdrental
DVD Reantal Demo

## Overview

![DVD Reantal Demo Architecture](docs/dvdrental_architecture.png)

## Building docker image
First of all we have to build docker image. We can do it by moving in `docker` folder and execute:
```docker
docker build -t dvdrental .
```
Docker will download all needed dependencies and build image with name "dvdrental". We can check it by execute:
```docker
docker images
```

## Running docker container
To run created image we have to execute "docker run" like this:
```docker
docker run -p 5433:5432 --name odm-demo-dvdrental --net host  dvdrental
```
Docker will run container with name "odm-demo-dvdrental", based on image "dvdrental" and it will expose containers port 5432 on localhost port 5433.

## Creating product tables
To create the tables exposed by the implemented data products we move in the pipeline folder of the product and execute the command `dbt run` like in the following example

```docker
cd ./products/sadp-loyacustomerslty/implementation/pipelines/dvdrental_customers
dbt run
```

All dbt models use the profile `dvdrental` defined as follow...

```yaml
dvdrental:
  outputs:

    prod:
      type: postgres
      threads: 1
      host: localhost
      port: 5432
      user: postgres
      pass: postgres
      dbname: dvdrental
      schema: public

    

  target: prod
```

To succesfully execute `dbt run` command we must add it to our `profiles.yml` file

