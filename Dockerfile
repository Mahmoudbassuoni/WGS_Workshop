# Use an official Ubuntu base image
FROM ubuntu:20.04
MAINTAINER Mahmoud Bassyouni <mahmoud.bassyouni@marc-eg.org>
LABEL description="Image for use with the WGS Workshop organized by MARC for medical services and scientific research"

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic Linux tools
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    automake \
    bzip2 \
    ca-certificates \
    cmake \
    curl \
    gcc \
    g++ \
    gawk \
    git \
    gnuplot \
    htop \
    less \
    libatomic-ops-dev \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-gnutls-dev \
    libgif-dev \
    libhts-dev \
    libjemalloc-dev \
    libjpeg-dev \
    liblzma-dev \
    libncurses5-dev \
    libssl-dev \
    libz-dev \
    libzstd-dev \
    make \
    ncurses-dev \
    openjdk-11-jre \
    perl \
    pigz \
    pkg-config \
    python3 \
    python3-dev \
    python3-distutils \
    python3-pip \
    unzip \
    wget \
    zlib1g \
    zlib1g-dev \
    uuid-runtime \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /miniconda && \
    rm /miniconda.sh
ENV PATH="/miniconda/bin:${PATH}"

# Update Conda
RUN conda update -y -n base -c defaults conda

# Install analysis tools
# Install FastQC for quality checks
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip -O /tmp/fastqc.zip && \
    unzip /tmp/fastqc.zip -d /opt/ && \
    chmod 755 /opt/FastQC/fastqc && \
    ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc && \
    rm /tmp/fastqc.zip

# Install BWA for alignments
RUN git clone https://github.com/lh3/bwa.git && \
    cd bwa && \
    make && \
    mv bwa /usr/local/bin/ && \
    cd .. && \
    rm -rf bwa
    
# Install Trimmomatic
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip -O /tmp/trimmomatic.zip && \
    unzip /tmp/trimmomatic.zip -d /opt/ && \
    ln -s /opt/Trimmomatic-0.39/trimmomatic-0.39.jar /usr/local/bin/trimmomatic && \
    rm /tmp/trimmomatic.zip

#Install sra-tools
ARG VERSION=current
RUN curl https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${VERSION}/sratoolkit.${VERSION}-centos_linux64-cloud.tar.gz | tar xz -C /
ENV PATH=/usr/local/ncbi/sra-tools/bin:${PATH}
RUN mkdir -p /root/.ncbi && \
    printf '/LIBS/IMAGE_GUID = "%s"\n' `uuidgen` > /root/.ncbi/user-settings.mkfg && \
    printf '/libs/cloud/report_instance_identity = "true"\n' >> /root/.ncbi/user-settings.mkfg
    
# Install SnpEff
RUN wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip -O /tmp/snpeff.zip && \
    unzip /tmp/snpeff.zip -d /opt/ && \
    ln -s /opt/snpEff/snpEff.jar /usr/local/bin/snpEff && \
    ln -s /opt/snpEff/SnpSift.jar /usr/local/bin/SnpSift && \
    rm /tmp/snpeff.zip

# Install bcftools
RUN wget https://github.com/samtools/bcftools/releases/download/1.10.2/bcftools-1.10.2.tar.bz2 -O /tmp/bcftools.tar.bz2 && \
    tar -xjf /tmp/bcftools.tar.bz2 -C /opt/ && \
    cd /opt/bcftools-1.10.2 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd / && \
    rm -rf /opt/bcftools-1.10.2 /tmp/bcftools.tar.bz2

# Install SAMtools
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 -O /tmp/samtools.tar.bz2 && \
    tar -xjf /tmp/samtools.tar.bz2 -C /opt/ && \
    cd /opt/samtools-1.10 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd / && \
    rm -rf /opt/samtools-1.10 /tmp/samtools.tar.bz2

# Install GATK
RUN wget https://github.com/broadinstitute/gatk/releases/download/4.1.9.0/gatk-4.1.9.0.zip -O /tmp/gatk.zip && \
    unzip /tmp/gatk.zip -d /opt/ && \
    ln -s /opt/gatk-4.1.9.0/gatk /usr/local/bin/gatk && \
    rm /tmp/gatk.zip

# Set the default command to bash
CMD ["/bin/bash"]
