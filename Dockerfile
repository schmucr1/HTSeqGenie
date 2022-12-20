# Version-stable base R & src build tools
FROM rocker/tidyverse

LABEL author="Roland Schmucki" \
      description="R with HTSeqGenie package from Bioconductor" \
      maintainer="roland.schmucki@roche.com"

ARG GITHUB_PAT

RUN apt-get update -y && apt-get install -y \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libgit2-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libpng-dev \
    libssl-dev \
    libtiff5-dev \
    libx11-dev \
    libxml2-dev \
    libxt-dev \
    r-cran-httr && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

RUN R -e "parallel::detectCores(); \
    options(Ncpus = 16); \
    chooseCRANmirror(ind = 1); \
    BiocManager::install(c('HTSeqGenie', \
                        'TxDb.Hsapiens.UCSC.hg19.knownGene', \
                        'TxDb.Hsapiens.UCSC.hg38.knownGene', \
                        'BSgenome.Hsapiens.UCSC.hg19'), \
                        dependencies = TRUE, \
                        upgrade_dependencies = TRUE)" && \
    rm -rf /tmp/downloaded_packages/ /tmp/*.rds 
