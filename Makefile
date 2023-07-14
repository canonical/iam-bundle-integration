.PHONY: init fmt validate plan

## help:     Show help messages.
help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

## init:     Initialize remote S3 backend.
init:
	@terraform init

## fmt:      Format the Terraform module to a canonical format and style.
fmt:
	@terraform fmt -recursive

## validate: Check syntactical validation.
validate:
	@terraform validate

## plan:     Plan the changes.
plan: verify-var-file-set
	@terraform plan -var-files=${VAR_FILE}

verify-var-file-set:
ifndef VAR_FILE
	$(error VAR_FILE is not defined. Please provide VAR_FILE.)
endif
