# Helm Stop Plugin
This is a Helm plugin which stops a release pods. It works by setting a release `replica` to zero (via `helm upgrade`).

## Usage

```
$ helm stop [REPLICA_VALUE_NAME] [RELEASE_NAME] [CHART_PATH]
```

## Example

*Note: This example is a local modified version of `stable/mysql` chart. It is modified to add a value `replicasValue` which is used to set the `replicas` (also added) during deployment.*

```
$ kubectl get all
NAME                                                     READY     STATUS             RESTARTS   AGE
calling-owl-mysql-6467975486-2rc86                       1/1       Running            0          48m
calling-owl-mysql-6467975486-6sj4s                       1/1       Running            15         48m
calling-owl-mysql-6467975486-s5vc2                       1/1       Running            15         48m

.......................

NAME                                               DESIRED   CURRENT   READY     AGE
calling-owl-mysql-6467975486                       3         3         3         1d

$ cat /tmp/charts/stable/mysql/values.yaml

.......................

imagePullPolicy: IfNotPresent

replicasValue: 2

.......................

$ cat /tmp/charts/stable/mysql/

.......................

spec:
  replicas: {{ .Values.replicasValue }}
  
.......................

$ helm stop replicasValue calling-owl /tmp/charts/stable/mysql/templates/deployment.yaml
Release "calling-owl" has been upgraded. Happy Helming!

.......................................

$ kubectl get all

NAME                                                     READY     STATUS    RESTARTS   AGE

.......................................

NAME                                               DESIRED   CURRENT   READY     AGE
calling-owl-mysql-6467975486                       0         0         0         2d
```

## Install

```
$ helm plugin install https://github.com/hickeyma/helm-stop
```
