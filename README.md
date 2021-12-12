## This repository was created to deploy all necessary resources to provisioning an EKS cluster with a Nginx pod running on it.


# How to use:

## DEV Enviroment:

to apply commit to branch main with the message:
```
tf apply dev
```

to destroy, commit to branch main with the message:
```
tf destroy dev
```

to remove a resource from tf state:
```
tf state rm dev - resource_name
```


## PROD Enviroment:

to apply, commit to branch main with the message:
```
tf apply prod
```

to destroy, commit to branch main with the message:
```
tf destroy prod
```

to remove a resource from tf state:
```
tf state rm prod - resource_name
```