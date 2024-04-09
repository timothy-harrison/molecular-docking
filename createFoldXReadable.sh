foldx --command=PDBFile --pdb=$1
mv PF_`basename $1 .pdb`.fxout PF_$1
