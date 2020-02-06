FROM rocker/r-ubuntu:18.04
# base for the R-based analysis

MAINTAINER "Brad Ito" brad@retina.ai

# upgrade and setup a clean system
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y build-essential apt-utils \
  && apt-get autoremove -y && apt-get clean

# install system dependencies for R packages
RUN apt-get update \
  && apt-get install -y \
    texlive \
    texlive-latex-extra \
  && apt-get autoremove -y
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    curl \
    default-jdk \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libmagick++-dev \
    r-cran-rstan \
    r-cran-catools \
  && apt-get autoremove -y && apt-get clean

# set the repo which we are using for R packages
# NOTE: The snapshot date should be upgraded regularly
# as a Docker ENV variable, it can also be specified when building
ENV CRANLIKE_REPO=https://mran.microsoft.com/snapshot/2020-02-01
RUN echo "options(repos = c(CRAN = '${CRANLIKE_REPO}'))" >> /etc/R/Rprofile.site

# install R packages

# install "basic" packages
# https://github.com/eddelbuettel/littler/blob/master/inst/examples/install2.r
RUN install2.r --error --repos=$CRANLIKE_REPO \
  devtools roxygen2 testthat tidyverse

# install packages used for specific purposes
COPY install_packages.R /tmp/install_packages.R
RUN CRANLIKE_REPO=$CRANLIKE_REPO r /tmp/install_packages.R


