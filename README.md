# Whole Genome Sequencing Workshop - MARC

Welcome to the GitHub repository for the MARC-organized Whole Genome Sequencing (WGS) Workshop. This workshop is designed to provide comprehensive training in WGS techniques using a range of bioinformatics tools.

## About the Workshop

This workshop covers various aspects of WGS, including quality control, alignment, variant calling, and annotation. It's ideal for students, researchers, and professionals who are keen to learn about WGS pipeline using practical, hands-on exercises.

## Docker Image

To ensure a uniform environment for all participants, we use a Docker image that contains all the necessary bioinformatics tools.

### Using the Docker Image

1. **Pull the Docker Image**:
   ```bash
   sudo docker pull mahmoudbassyouni/wgs_workshop_marc:1.0.0
2. **Run the Docker Container**
   ```bash
   sudo docker run -it -v $HOME:/data/ mahmoudbassyouni/wgs_workshop_marc:1.0.0
This Docker image includes tools such as FastQC, Trimmomatic, BWA, SAMtools, bcftools, and SnpEff, preconfigured for immediate use.

## Schedule
[Include a detailed schedule of the workshop here]

## Prerequisites
* Basic knowledge of genomics and bioinformatics.
* Familiarity with command-line interfaces and Docker.

## Contributing
We welcome contributions to improve the workshop material and Docker image.

## Contact
For any queries regarding the workshop, feel free to reach out to [Mahmoud Bassyouni. Email: mahmoud.bassyouni@marc-eg.org].
## License
This project is licensed under the [MIT License] - see the [LICENSE.md](https://github.com/Mahmoudbassuoni/WGS_Workshop/blob/main/README.md) file for details.
