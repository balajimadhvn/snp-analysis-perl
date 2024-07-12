SNP Analysis Tool in Perl
Description
This Perl script is designed for analyzing Single Nucleotide Polymorphism (SNP) data from Variant Call Format (VCF) files. It reads SNP data, calculates genotype frequencies across samples, and provides basic statistical analysis.

Features
Read VCF Files: Parses SNP data from VCF files.
Calculate Genotype Frequencies: Computes genotype frequencies for each SNP across samples.
Simple and Extendable: Easily extendable for additional SNP analyses and visualizations.
Usage
Prerequisites
Perl 5.x or higher installed on your system.
Getopt::Long module (usually included in Perl distributions).
Installation
Clone the repository:

bash
Copy code
git clone https://github.com/balajimadhvn/snp-analysis-perl.git
cd snp-analysis-perl
Running the Script
To run the SNP analysis tool, execute the Perl script snp_analysis.pl with the following command-line options:

bash
Copy code
./snp_analysis.pl -v /path/to/your/snp_data.vcf
Command-line Options
-v, --vcf: Path to the VCF file containing SNP data (required).
-h, --help: Display usage instructions.
Example
To analyze SNP data in the file example_data.vcf, run:

bash
Copy code
./snp_analysis.pl -v example_data.vcf
Output
The script calculates genotype frequencies and prints results to the standard output.
