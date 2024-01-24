# DAY 3, Practical Session

## Part [1] : Variants Filtration 
```
for sample in `cat accession.txt`;
do
    # Variant Filtration    
    gatk VariantFiltration \
           --variant gatk/"${sample}".g.vcf.gz \
           --output gatk/"${sample}"_filtered.g.vcf.gz \
           --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0" \
           --filter-name "MY_SNP_FILTER"
done
```
## Part [2] : Variants Annotation
```
mkdir stats

for sample in `cat accession.txt`;
do
    # SnpEff for Variant Annotation
    java -jar /opt/snpEff/snpEff.jar ann -v GRCh38.86 -html -stats stats/"${sample}"_snpEff_summary.html gatk/"${sample}"_filtered.g.vcf.gz > gatk/"${sample}"_annotated.vcf
done
```