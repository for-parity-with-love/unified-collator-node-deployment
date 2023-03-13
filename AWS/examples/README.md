# Usage
The only additional thing you need to configure to run examples is a separate AWS access key named "collator"

```
~/.aws/credentials
[default]
aws_access_key_id = <aws_access_key_id>
aws_secret_access_key = <aws_secret_access_key>

[collator]
aws_access_key_id = <aws_access_key_id>
aws_secret_access_key = <aws_secret_access_key>
```

This is a good practice to separate resources and usage of example run and production. Once you have configured AWS profile then run [deploy.sh](AWS/examples/deploy.sh) and follow the instruction to run one of the example setups.

## Clean up
Once you have finished with your tests, run [destroy.sh](AWS/examples/destroy.sh) and choose the same collator you rolled out.


<details>
  <summary>WARN</summary>
    deploy.sh and destroy.sh script was created just for demonstartion. We don't support and don't guarantee the work of this collators properly a few time later. Use at own risk.
</details>
