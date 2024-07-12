#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

# Global variables to store command-line options
my $vcf_file;
my $help;

# Function to print usage information
sub print_usage {
    print "Usage: $0 -v <vcf_file>\n";
    print "Options:\n";
    print "  -v, --vcf     Path to the VCF file containing SNP data (required)\n";
    print "  -h, --help    Display this help message\n";
    exit;
}

# Function to read SNP data from a VCF file
sub read_vcf_file {
    my ($filename) = @_;
    open(my $fh, '<', $filename) or die "Cannot open file $filename: $!";
    
    my @snps;
    while (my $line = <$fh>) {
        chomp $line;
        next if $line =~ /^#/;  # Skip header lines
        
        my ($chrom, $pos, $id, $ref, $alt, $qual, $filter, $info, $format, @samples) = split /\t/, $line;
        push @snps, {
            chrom   => $chrom,
            pos     => $pos,
            id      => $id,
            ref     => $ref,
            alt     => $alt,
            qual    => $qual,
            filter  => $filter,
            info    => $info,
            format  => $format,
            samples => \@samples,
        };
    }
    
    close($fh);
    return \@snps;
}

# Function to calculate genotype frequencies
sub calculate_genotype_frequencies {
    my ($snps) = @_;
    
    my %genotype_counts;
    foreach my $snp (@$snps) {
        foreach my $sample (@{$snp->{samples}}) {
            my ($gt, $dp, $gq, @ad) = split /:/, $sample;
            $genotype_counts{$gt}++;
        }
    }
    
    my $total_samples = scalar @{$snps->[0]->{samples}};  # Assuming all SNPs have the same number of samples
    foreach my $genotype (sort keys %genotype_counts) {
        my $frequency = $genotype_counts{$genotype} / $total_samples;
        printf "Genotype %s: %.2f\n", $genotype, $frequency;
    }
}

# Main script
sub main {
    # Parse command-line options
    GetOptions(
        'v|vcf=s' => \$vcf_file,
        'h|help'  => \$help,
    ) or die "Error in command line arguments. See usage with '$0 -h'\n";
    
    # Print usage if help flag is provided or if VCF file is missing
    print_usage() if $help or !defined $vcf_file;
    
    # Read SNP data from VCF file
    my $snps = read_vcf_file($vcf_file);
    
    # Calculate genotype frequencies
    calculate_genotype_frequencies($snps);
}

# Run the main subroutine
main();

