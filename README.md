# aws-neptune-playground

CloudFormation templates, scripts and notes for working with Amazon Neptune.

## Prerequisites

* VPC, subnet and bucket stacks from [sjakthol/aws-account-infra](https://github.com/sjakthol/aws-account-infra).

## Deployment

```bash
# Create a Neptune cluster
make deploy-neptune-cluster

# Create infra for Neptune Analytics graph
make deploy-neptune-graph
```

Once complete, you can use the Neptune console to create an Analytics graph from the
Neptune cluster (use stack outputs to fill the create form).

## Cleanup

```bash
# Delete infra for Neptune Analytics graph (delete the graph first manually)
make delete-neptune-graph

# Delete infra for Neptune cluster
make delete-neptune-cluster
```

## License

MIT.
