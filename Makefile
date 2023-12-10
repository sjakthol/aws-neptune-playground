AWS_eu-north-1_PREFIX = en1
AWS_eu-west-1_PREFIX = ew1
AWS_us-east-1_PREFIX = ue1
AWS_us-west-2_PREFIX = uw2

STACK_NAME_PREFIX := $(AWS_$(AWS_REGION)_PREFIX)-neptune-playground
TAGS ?= Project=$(STACK_NAME_PREFIX)

# Generic deployment and teardown targets
deploy-%:
	aws cloudformation deploy \
		--stack-name $(STACK_NAME_PREFIX)-$* \
		--tags $(TAGS) \
		--template-file templates/$*.yaml \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides StackNamePrefix=$(STACK_NAME_PREFIX) \
		$(EXTRA_ARGS)

delete-%:
	aws cloudformation delete-stack \
		--stack-name $(STACK_NAME_PREFIX)-$*

# Concrete deploy and delete targets for autocompletion
$(addprefix deploy-,$(basename $(notdir $(wildcard templates/*.yaml)))):
$(addprefix delete-,$(basename $(notdir $(wildcard templates/*.yaml)))):

# Customizations
delete-neptune-graph: pre-delete-neptune-graph
pre-delete-neptune-graph:
	-aws s3 rm --recursive s3://$(STACK_NAME_PREFIX)-neptune-graph-data