#!/bin/bash

export AWS_ACCESS_KEY_ID="<your access key id>"
export AWS_SECRET_ACCESS_KEY="<your screct accekk key>"
export AWS_DEFAULT_REGION="<your region>"

/usr/bin/aws.orig $@
