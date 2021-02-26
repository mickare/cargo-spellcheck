#!/bin/bash
set -e

# This unpacks the GH action args string, normally "$@" would be 
cargo spellcheck $@
