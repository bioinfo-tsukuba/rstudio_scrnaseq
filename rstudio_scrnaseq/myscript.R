#!/usr/bin/env Rscript

# GitHub PAT (Personal access token)
args <- commandArgs(trailingOnly = T)
GITHUB_PAT <- args[1]
Sys.setenv(GITHUB_PAT = GITHUB_PAT)

library(dplyr)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(ask=FALSE)

# package list
bio_packages <- read.table("package_list.txt")

# package list install BioConductor
pkgs <-
  bio_packages %>%
  filter(V2 == "bc") %>%
  .[,1]

for(pkg in pkgs) if (!require(pkg, character.only = T)){
  BiocManager::install(pkg, ask=FALSE)
  require(pkg, character.only = T)
}

# package list install CRAN
pkgs <-
  bio_packages %>%
  filter(V2 == "cran") %>%
  .[,1]
options(repos = c(CRAN = "https://cran.r-project.org"))
install.packages(pkgs)

# install_github
devtools::install_github("sqjin/CellChat")
devtools::install_github("Wei-BioMath/NeuronChat")
devtools::install_github("mojaveazure/seurat-disk")
devtools::install_github("ayshwaryas/ddqc_R")
devtools::install_github("haotian-zhuang/findPC")
devtools::install_github("igrabski/sc-SHC")
devtools::install_github("siyao-liu/MultiK")
devtools::install_github("aertslab/SCopeLoomR", build_vignettes = TRUE)
remotes::install_github("aertslab/RcisTarget") # scenic依存
remotes::install_github("bokeh/rbokeh") # scenic依存
devtools::install_github("aertslab/SCENIC")
devtools::install_github("immunogenomics/presto")
update.packages(oldPkgs = c("withr", "rlang"))
remotes::install_github('satijalab/azimuth', ref = 'master')
remotes::install_github("pmbio/MuDataSeurat")
devtools::install_github('cole-trapnell-lab/monocle3')
remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')
remotes::install_github('satijalab/seurat-wrappers')
devtools::install_github("AllenInstitute/cocoframer")

