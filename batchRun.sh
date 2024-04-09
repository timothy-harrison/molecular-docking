#! /bin/bash
mkdir -p output

for l in lipids/*.pdbqt; do
	for f in receptors/*.pdbqt; do 
		echo processing receptor $f and ligand $l 
		ligand_base=`basename $l .pdbqt`
		receptor_base=`basename $f .pdbqt`
		output_name="${ligand_base}-${receptor_base}"
		vina --config vina_conf.txt --ligand $l --receptor $f --out output/$output_name.pdbqt
	done
done
