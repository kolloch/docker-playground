#!/bin/bash

exec docker build $* -t cassandra_opscenter .
