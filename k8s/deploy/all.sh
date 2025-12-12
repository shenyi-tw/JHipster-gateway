#!/bin/bash

rebuild=1
rebuild=no
sh frontend.sh $rebuild
sh go-minio-chart.sh $rebuild
sh go-product-chart.sh $rebuild
sh java-blog-chart.sh $rebuild
sh java-gateway-chart.sh $rebuild

