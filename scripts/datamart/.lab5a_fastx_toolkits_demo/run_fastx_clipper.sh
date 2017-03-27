#!/bin/sh

fastx_clipper -a CCTTAAGG -l 5 -i test_1.fq -o test_1_clipper.fq
fastx_clipper -a CCTTAAGG -l 5 -i test_2.fq -o test_2_clipper.fq
