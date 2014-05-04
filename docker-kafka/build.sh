#!/bin/bash

exec docker build $* -t kafka .
