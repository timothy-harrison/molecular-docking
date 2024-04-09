mkdir -p variants
foldx --command=BuildModel --pdb=$1 --output-dir=variants --mutant-file=individual_list.txt
