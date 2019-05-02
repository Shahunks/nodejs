#!/bin/bash


consul-template -config /usr/src/app/consul-template.hcl -log-level debug &
npm start
