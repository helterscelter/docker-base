#!/bin/sh 
#
# simple bash-based template engine.. uses HEREDOC semantics and eval/env variable replacement
# to populate a proper template.  This works only for somewhat simple configuration templates

TEMPLATE=$1
shift
DEST=$1
shift

eval "cat > ${DEST} << EOF
$(cat ${TEMPLATE})
EOF"

